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
//    @Published var units = "imperial"
    @AppStorage("Units") var units = "imperial"

//    @Published var unitLogo = "℉"
    @AppStorage("UnitLogo") var unitLogo = "℉"

    
    @Published var backgroundColor: LinearGradient = LinearGradient(colors: [.blue, .blue, .purple], startPoint: .top, endPoint: .bottom)
    @Published var searchBarColor = Color.blue
    
    @Published var latForCoreData: Double = 0.0
    @Published var lonForCoreData: Double = 0.0
    @Published var dateForCoreData = ""
    @Published var errorAlertForMainScreen = false
    @Published var errorAlertForSearch = false

    let weatherFuntions = WeatherFunction()
    
    
    var numOfTimesErrorIsCalled = 0

    
    private let apiKey = K.apiKey
    private let oneCallUrl = "https://api.openweathermap.org/data/2.5/onecall?"
    private let directGeocodeAPI = "https://api.openweathermap.org/geo/1.0/direct?"
    
    let manager = CLLocationManager()
    static let shared = WeatherViewModel()
    
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        manager.startUpdatingLocation()
//        performGeocodeRequest(with: directGeocodeAPI)
    }
    
    func makeAlertAppear() {
        DispatchQueue.main.async {
            self.errorAlertForMainScreen.toggle()

        }
    }
    
    
    func incorrectSearchAlert() {
        DispatchQueue.main.async {
            self.errorAlertForSearch.toggle()
        }
        
    }
    
}


//MARK: - Geocode API
extension WeatherViewModel {
    func performGeocodeRequest(with cityName: String) {
        
        guard let apiKey = apiKey else { fatalError("Could not get apikey")}
        
        let geocodeURL = "\(directGeocodeAPI)q=\(cityName)&appid=\(apiKey)"
        
        
        if let url = URL(string: geocodeURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("Could not perform geocode: \(error)")
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let geocodeData = try decoder.decode([GeocodeData].self, from: safeData)
                        
                        if geocodeData.isEmpty {
                            print("The geocode is empty")
                            self.incorrectSearchAlert()
                            return
                            //make alert that tells user the name is invalid
                        } else {
                            print("The geoCode data is: \(geocodeData)")

                            let geoCityName = geocodeData[0].name
                            let geoCountryName = geocodeData[0].country
                            let geoLat = geocodeData[0].lat
                            let geoLon = geocodeData[0].lon
                            
                            print( geocodeData[0].name)
                            print("Geo coordinates: Lat - \(geocodeData[0].lat) || lon - \(geocodeData[0].lon)")
                            self.getWeatherWithCoordinates(latitude: geoLat, longitude: geoLon)
                            
                            DispatchQueue.main.async {
                                if let state = geocodeData[0].state {
                                    self.userLocation = "\(geoCityName), \(state)"
                                } else {
                                    self.userLocation = "\(geoCityName), \(geoCountryName)"
                                }
                            }
                            
                            
                            
                        }

                    } catch {
                        print("Error decoding geocode data: \(error)")
                    }
                }
            }
            task.resume()
        }
        
    }
    
}




//MARK: - Work with API
extension WeatherViewModel {
    func getWeatherWithCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print("get with coordinates")
        guard let apiKey = apiKey else { fatalError("Could not get apiKey") }
        
        let urlString = "\(oneCallUrl)lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=\(units)&appid=\(apiKey)"

        
        performRequest(urlString)
        DispatchQueue.main.async {
            self.latForCoreData = latitude
            self.lonForCoreData = longitude
        }

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
                            self.dateForCoreData = currentTime
                            let sunrise = weatherData.current.sunrise
                            let sunset = weatherData.current.sunset
                            let currentTemp = String(format: K.noDecimals, weatherData.current.temp)
                            let feelsLikeTemp = String(format: K.noDecimals, weatherData.current.feels_like)
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
//                                self.searchBarColor = .red
                                self.searchBarColor = self.weatherFuntions.getAppropriateSearchBarColor(currentSunriseTime: sunrise, currentSunsetTime: sunset, currentTime: weatherData.current.dt)
                                self.backgroundColor = self.weatherFuntions.getAppropriateBackgroundColor(currentSunriseTime: sunrise, currentSunsetTime: sunset, currentTime: weatherData.current.dt)

                                if self.units == K.metric {
                                    self.unitLogo = "℃"
                                } else {
                                    self.unitLogo = "℉"
                                }
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



                            for i in 0..<K.WeatherConstants.dailyHours {
                                hourlyTemp.append(weatherData.hourly[i].temp)
                                hourlyTime.append(weatherData.hourly[i].dt)
                                hourlyPop.append(String(format: K.noDecimals, weatherData.hourly[i].pop * 100))
                                hourlyIcon.append(self.weatherFuntions.getSFSymbolWeatherIcon(apiIcon: weatherData.hourly[i].weather[0].icon))
                                hourlyIconColor.append(self.weatherFuntions.getSFColorForIcon(sfIcon: hourlyIcon[i]))
                            }
                            
                            //readable hours example -- 7 AM
                            let times = self.weatherFuntions.getReadableHour(hourInSecond: hourlyTime, timezoneOffset: weatherData.timezone_offset)

                            var timedAnimation = 0.0
                            for i in 0..<K.WeatherConstants.dailyHours {
                                
                                
                                withAnimation(.easeIn(duration: timedAnimation)) {
                                    
                                    self.hourlyWeather.append(HourlyWeatherModel(temp: String(format: K.noDecimals, hourlyTemp[i]),
                                                                                 time: times[i],
                                                                                 pop: hourlyPop[i] + "%",
                                                                                 icon: hourlyIcon[i],
                                                                                 iconColor: hourlyIconColor[i])
                                    )
                                    
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
                            
                            var morningTemps: [Double] = []
                            var daytimeTemps: [Double] = []
                            var eveningTemps: [Double] = []
                            var nighttimeTemps: [Double] = []
                            var minimumTemps: [Double] = []
                            var maximumTemps: [Double] = []
                            
                            var morningFeelsLike: [Double] = []
                            var daytimeFeelsLike: [Double] = []
                            var eveningFeelsLike: [Double] = []
                            var nighttimeFeelsLike: [Double] = []
                            
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
                                
                                morningTemps.append(weatherData.daily[i].temp.morn)
                                daytimeTemps.append(weatherData.daily[i].temp.day)
                                eveningTemps.append(weatherData.daily[i].temp.eve)
                                nighttimeTemps.append(weatherData.daily[i].temp.night)
                                minimumTemps.append(weatherData.daily[i].temp.min)
                                maximumTemps.append(weatherData.daily[i].temp.max)
                                
                                
                                morningFeelsLike.append(weatherData.daily[i].feels_like.morn)
                                daytimeFeelsLike.append(weatherData.daily[i].feels_like.day)
                                eveningFeelsLike.append(weatherData.daily[i].feels_like.eve)
                                nighttimeFeelsLike.append(weatherData.daily[i].feels_like.night)
                                
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
                                                                           morningTemp: String(format: K.noDecimals, morningTemps[i]),
                                                                           daytimeTemp: String(format: K.noDecimals, daytimeTemps[i]),
                                                                           eveningTemp: String(format: K.noDecimals, eveningTemps[i]),
                                                                           nighttimeTemp: String(format: K.noDecimals, nighttimeTemps[i]),
                                                                           minimumTemp: String(format: K.noDecimals, minimumTemps[i]),
                                                                           maximumTemp: String(format: K.noDecimals, maximumTemps[i]),
                                                                           morningFeelsLike: String(format: K.noDecimals, morningFeelsLike[i]),
                                                                           daytimeFeelsLike: String(format: K.noDecimals, daytimeFeelsLike[i]),
                                                                           eveningFeelsLike: String(format: K.noDecimals, eveningFeelsLike[i]),
                                                                           nightimeFeelsLike: String(format: K.noDecimals, nighttimeFeelsLike[i]),
                                                                           humidity: String(format: K.noDecimals, allHumidities[i]),
                                                                           windspeed: String(format: K.twoDecimals, windSpeeds[i]),
                                                                           windDegrees: String(format: K.twoDecimals, windDegrees[i]),
                                                                           description: descriptions[i],
                                                                           chanceOfPrecipitation: String(format: K.noDecimals, allPrecipitations[i] * 100),
                                                                           uvIndex: String(format: K.twoDecimals, allUVIndex[i]),
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
        numOfTimesErrorIsCalled += 1
        print("There was an error: \(error.localizedDescription)")
        //Implement alert telling user to change location preferences in settings
//        makeAlertAppear()
        print("didFailWithError")
        
        if numOfTimesErrorIsCalled > 1 {
            makeAlertAppear()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            print("Status is denied")
            makeAlertAppear()
        } else if status == .authorizedWhenInUse {
            print("Status is set to authorize while in use only")
        } else if status == .notDetermined {
            print("Status not determined yet")
        } else if status == .authorizedAlways {
            print("Status is set to authorized always")
        }
    }
}




extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
