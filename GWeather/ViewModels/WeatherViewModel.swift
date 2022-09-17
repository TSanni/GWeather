//
//  WeatherViewModel.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI




class WeatherViewModel: NSObject, ObservableObject {
    
    @Published var currentWeather: CurrentWeatherModel = CurrentWeatherModel.shared
    @Published var tomorrowWeather: TomorrowWeatherModel = TomorrowWeatherModel.shared
    @Published var hourlyWeather: [HourlyWeatherModel] = [HourlyWeatherModel.shared, HourlyWeatherModel.shared]
    @Published var dailyWeather: [DailyWeatherModel] = [DailyWeatherModel.shared, DailyWeatherModel.shared]
    @Published var userLocation = "Earth"
    @Published var units = "imperial"
    @Published var unitLogo = "℉"
    
    
    let weatherFuntions = WeatherFunction()
    
    private let apiKey = K.apiKey
    private let oneCallUrl = "https://api.openweathermap.org/data/2.5/onecall?"
    
    let manager = CLLocationManager()
    static let shared = WeatherViewModel()
    
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        manager.startUpdatingLocation()
    }
    
    
    
}

//MARK: - Work with API
extension WeatherViewModel {
    func getWeatherWithCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print("get with coordinates")
        guard let apiKey = apiKey else { fatalError("Could not get apiKey") }
        
        let urlString = "\(oneCallUrl)lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=\(units)&appid=\(apiKey)"

        
        performRequest(urlString)
        
    }
    
    
    
    func performRequest(_ urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Could not start session: \(error)")
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let weatherData = try decoder.decode(WeatherData.self, from: safeData)
                        
                        //MARK:  Main thread For current conditions
                        DispatchQueue.main.async {
                            
                            let currentTime = self.weatherFuntions.getDate(timezoneOffset: weatherData.timezone_offset)
                            let sunrise = weatherData.current.sunrise
                            let sunset = weatherData.current.sunset
                            let currentTemp = String(format: "%.0f", weatherData.current.temp)
                            let feelsLikeTemp = String(format: "%.0f", weatherData.current.feels_like)
                            let description = weatherData.current.weather[0].description
                            let sfIcon = self.weatherFuntions.getSFSymbolWeatherIcon(apiIcon: weatherData.current.weather[0].icon)
                            let sfColor = self.weatherFuntions.getSFColorForIcon(sfIcon: sfIcon)
                            let readableSunrise = self.weatherFuntions.getSunriseSunsetTimes(timeInSeconds: [sunrise], timezoneOffset: weatherData.timezone_offset, getShortHour: false)
                            let readableSunset = self.weatherFuntions.getSunriseSunsetTimes(timeInSeconds: [sunset], timezoneOffset: weatherData.timezone_offset, getShortHour: false)
                            
                            withAnimation {
                                
                                self.currentWeather = CurrentWeatherModel(currentTime: currentTime,
                                                                          sunrise: readableSunrise[0],
                                                                          sunset: readableSunset[0],
                                                                          currentTemp: currentTemp,
                                                                          feelsLike: feelsLikeTemp,
                                                                          description: description,
                                                                          icon: sfIcon,
                                                                          iconColor: sfColor
                                )
                            }
                            
                        }
                        
                        
                        //MARK:  Main thread for Hourly Conditions
                        DispatchQueue.main.async {
                            self.hourlyWeather = []
                            var hourlyTemp: [Double] = []
                            var hourlyTime: [Double] = []
                            var hourlyIcon: [String] = []
                            var hourlyPop: [String] = []
                            
                            var hourlyIconColor: [[Color]] = []
                            let sunrise = weatherData.current.sunrise
                            let sunset = weatherData.current.sunset
                            
                            //Will read like 7 AM
                            let readableSunrise = self.weatherFuntions.getSunriseSunsetTimes(timeInSeconds: [sunrise], timezoneOffset: weatherData.timezone_offset, getShortHour: true)
                            
                            let readableSunset = self.weatherFuntions.getSunriseSunsetTimes(timeInSeconds: [sunset], timezoneOffset: weatherData.timezone_offset, getShortHour: true)
                            
                            //Will read like 7:08 AM
                            let fullSunrise = self.weatherFuntions.getSunriseSunsetTimes(timeInSeconds: [sunrise], timezoneOffset: weatherData.timezone_offset, getShortHour: false)
                            
                            let fullSunset = self.weatherFuntions.getSunriseSunsetTimes(timeInSeconds: [sunset], timezoneOffset: weatherData.timezone_offset, getShortHour: false)


                            for i in 0..<K.WeatherConstants.dailyHours {
                                hourlyTemp.append(weatherData.hourly[i].temp)
                                hourlyTime.append(weatherData.hourly[i].dt)
                                hourlyPop.append(String(format: "%.0f", weatherData.hourly[i].pop * 100))
                                hourlyIcon.append(self.weatherFuntions.getSFSymbolWeatherIcon(apiIcon: weatherData.hourly[i].weather[0].icon))
                                hourlyIconColor.append(self.weatherFuntions.getSFColorForIcon(sfIcon: hourlyIcon[i]))
                            }
                            
                            //readable hours example -- 7 AM
                            let times = self.weatherFuntions.getReadableHour(hourInSecond: hourlyTime, timezoneOffset: weatherData.timezone_offset)

                            var timedAnimation = 0.0
                            for i in 0..<K.WeatherConstants.dailyHours {
                                
                                
                                withAnimation(.easeIn(duration: timedAnimation)) {
                                    
                                    self.hourlyWeather.append(HourlyWeatherModel(temp: String(format: "%.0f", hourlyTemp[i]),
                                                                                 time: times[i],
                                                                                 pop: hourlyPop[i] + "%",
                                                                                 icon: hourlyIcon[i],
                                                                                 iconColor: hourlyIconColor[i])
                                    )
                                    
                                    if readableSunrise[0] == times[i] {
                                        self.hourlyWeather.append(HourlyWeatherModel(temp: "Sunrise", time: fullSunrise[0], pop: hourlyPop[i] + "%", icon: K.WeatherCondition.sunrise, iconColor: [.white, .yellow, .clear]))
                                    }
                                    
                                    if readableSunset[0] == times[i] {
                                        self.hourlyWeather.append(HourlyWeatherModel(temp: "Sunset", time: fullSunset[0], pop: hourlyPop[i] + "%", icon: K.WeatherCondition.sunset, iconColor: [.white, .orange, .clear]))
                                    }
                                }
                        
                                timedAnimation += 0.1
                            }
            
                        }
                        
                        
                        
                        
                        
                        //MARK:  Main thread For Daily conditions
                        DispatchQueue.main.async {
                            self.dailyWeather = []
                            var datesInDouble: [Double] = []
                            var sunrises: [Double] = []
                            var sunsets: [Double] = []
                            var daytimeTemps: [Double] = []
                            var nighttimeTemps: [Double] = []
                            var minimumTemps: [Double] = []
                            var maximumTemps: [Double] = []
                            var allHumidities: [Double] = []
                            var windSpeeds: [Double] = []
                            var windDegrees: [Double] = []
                            
                            var descriptions: [String] = []
                            var allPrecipitations: [Double] = []
                            var allUVIndex: [Double] = []
                            var icons: [String] = []
                            var iconColors: [[Color]] = []
                            
                            
                            for i in 0..<weatherData.daily.count {
                                datesInDouble.append(weatherData.daily[i].dt)
                                sunrises.append(weatherData.daily[i].sunrise)
                                sunsets.append(weatherData.daily[i].sunset)
                                daytimeTemps.append(weatherData.daily[i].temp.day)
                                nighttimeTemps.append(weatherData.daily[i].temp.night)
                                minimumTemps.append(weatherData.daily[i].temp.min)
                                maximumTemps.append(weatherData.daily[i].temp.max)
                                allHumidities.append(weatherData.daily[i].humidity)
                                windSpeeds.append(weatherData.daily[i].wind_speed)
                                windDegrees.append(weatherData.daily[i].wind_deg)
                                descriptions.append(weatherData.daily[i].weather[0].description)
                                allPrecipitations.append(weatherData.daily[i].pop)
                                allUVIndex.append(weatherData.daily[i].uvi)
                                icons.append(self.weatherFuntions.getSFSymbolWeatherIcon(apiIcon: weatherData.daily[i].weather[0].icon))
                                iconColors.append(self.weatherFuntions.getSFColorForIcon(sfIcon: icons[i]))
                            }
                            
                            //Convert the dates in seconds to dates in regular english, need to do this for sunrise/sunset
                            let dates = self.weatherFuntions.getDailyDate(dateInDoubleFormat: datesInDouble, timezoneOffset: weatherData.timezone_offset)
                            let allSunrises = self.weatherFuntions.getSunriseSunsetTimes(timeInSeconds: sunrises, timezoneOffset: weatherData.timezone_offset, getShortHour: false)
                            let allSunsets = self.weatherFuntions.getSunriseSunsetTimes(timeInSeconds: sunsets, timezoneOffset: weatherData.timezone_offset, getShortHour: false)
                            
                            
                            
                            
                            
                            
                            //Creating a DailyWeatherModel struct for each day
                            for i in 0..<weatherData.daily.count {
                                self.dailyWeather.append(DailyWeatherModel(dates: dates[i],
                                                                           sunrise: allSunrises[i],
                                                                           sunset: allSunsets[i],
                                                                           daytimeTemp: String(format: "%.0f", daytimeTemps[i]),
                                                                           nighttimeTemp: String(format: "%.0f", nighttimeTemps[i]),
                                                                           minimumTemp: String(format: "%.0f", minimumTemps[i]),
                                                                           maximumTemp: String(format: "%.0f", maximumTemps[i]),
                                                                           humidity: String(format: "%.0f", allHumidities[i]),
                                                                           windspeed: String(format: "%.2f", windSpeeds[i]),
                                                                           windDegrees: String(format: "%.2f", windDegrees[i]),
                                                                           description: descriptions[i],
                                                                           chanceOfPrecipitation: String(format: "%.0f", allPrecipitations[i] * 100),
                                                                           uvIndex: String(format: "%.2f", allUVIndex[i]),
                                                                           icons: icons[i],
                                                                           iconColors: iconColors[i]
                                                                          )
                                )
                            }
                            
                        }
                        
                        
                        //MARK:  Main thread for tomorrow conditions
                        DispatchQueue.main.async {
                            self.tomorrowWeather = TomorrowWeatherModel(date: self.dailyWeather[1].dates, highTemp: self.dailyWeather[1].maximumTemp, lowTemp: self.dailyWeather[1].minimumTemp, weatherDescription: self.dailyWeather[1].description, icon: self.dailyWeather[1].icons, iconColor: self.dailyWeather[1].iconColors, chanceOfPrecipitation: self.dailyWeather[1].chanceOfPrecipitation)
                        }
                        
                        
                    } catch {
                        print("Error decoding data: \(error)")
                    }
                }
            }
            task.resume()
        }
        
    }
}



//MARK: - Work with Location Manager Delegate
extension WeatherViewModel: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("Latitude: \(lat) and longitude: \(lon)")
            getWeatherWithCoordinates(latitude: lat, longitude: lon)
            
            //MARK : Will work with this later
            let location = CLLocation(latitude:lat, longitude: lon)
            location.fetchCityAndCountry { city, country, error in
                guard let city = city, let country = country, error == nil else { return }
                print(city + ", " + country)  // Rio de Janeiro, Brazil
                self.userLocation = city + ", " + country
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("There was an error: \(error.localizedDescription)")
    }
}




extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
