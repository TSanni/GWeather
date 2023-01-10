//
//  PlacesView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct PlacesView: View {
    @State private var searchText = ""
    @State var degreeRotation: Double = 0
    @Binding var changeToPlacesView: Bool
    @EnvironmentObject var weather: WeatherViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timeAdded, order: .reverse)], animation: .easeInOut) var places: FetchedResults<Place>
    
    
    var body: some View {
        VStack {
            HStack {
                arrowButton
                textFieldSearch
            }.padding(.top)
            
            Divider()
                .padding()
            
            
            Menu {
                Button("Save location") {
                    addLocation()
                }
            } label: {
                currentLocationInfo

            }
            .disabled(weather.userLocation == "Earth" ? true : false)
            .padding(.bottom)
            
            HStack {
                Text("Saved locations")
                    .foregroundColor(.black)
                Spacer()
                EditButton()
                    .foregroundColor(.black)
            }
            
            Divider()
            
            List {
                if places.count == 0 {
                    Text("")
                        .listRowBackground(Color.clear)
                }
                ForEach(places) { place in
                    Button {
                        getNewWeather(place: place)
                    } label: {
                        SavedLocationsViews(place: place)
                            .padding(.vertical)
                    }

                    .listRowBackground(K.Colors.offWhite)
                }
                .onDelete(perform: deletePlace(at:))
            }
            .scrollContentBackground(.hidden)
        }
        .padding([.horizontal, .bottom])
        .background(.white)
        
    }
    
    func getNewWeather(place: Place) {
        print(place.wrappedName)
        weather.getWeatherWithCoordinates(latitude: place.wrappedLatitude, longitude: place.wrappedLongitude)
        DispatchQueue.main.async {
            weather.userLocation = place.wrappedName

        }
        withAnimation {
            changeToPlacesView = false
        }
    }
    
    
    func addLocation() {
        let addedCity = Place(context: moc)
        //dont need all this for core data
        //need to only store coordinates in core data
        addedCity.timeAdded = Date.now
        addedCity.name = weather.userLocation
        addedCity.date = weather.currentWeather.currentTime
        addedCity.date = weather.dateForCoreData
        addedCity.longitude = weather.lonForCoreData
        addedCity.latitude = weather.latForCoreData
        
        try? moc.save()
        print("The coordinates saved to core data: Lat: \(addedCity.wrappedLatitude) Lon: \(addedCity.wrappedLongitude)")
    }
    
    
    func deletePlace(at offsets: IndexSet) {
        for offset in offsets {
            let place = places[offset]
            moc.delete(place)
            
        }
        try? moc.save()
        
    }
    
    
    
    var arrowButton: some View {
        Button {
            withAnimation {
                degreeRotation -= 360
//                viewModel.changeToPlacesView = false
                changeToPlacesView = false
            }
        } label: {
            Image(systemName: "arrow.left")
                .rotationEffect(Angle(degrees: degreeRotation))
                .animation(.spring(), value: degreeRotation)
                .padding(.horizontal)
        }
    }
    
    var currentLocationInfo: some View {
        
        Button {
            
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.userLocation)
                        .foregroundColor(.black)
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                        Text("Chosen Location")
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                HStack {
                    Text(weather.currentWeather.currentTemp + weather.unitLogo)
                        .foregroundColor(.black)
                    Image(systemName: weather.currentWeather.icon)
                        .foregroundStyle(weather.currentWeather.iconColor[0],
                                         weather.currentWeather.iconColor[1],
                                         weather.currentWeather.iconColor[2]
                        )
                }
            }
        }



    }
    
    var textFieldSearch: some View {
        HStack {
            TextField("", text: $searchText)
                .placeholder(when: searchText.isEmpty) {
                    Text("Search places").foregroundColor(.gray)
                }
                .foregroundColor(.black)
                .onSubmit {
                    //Fix to accept strings with spaces
                    let newText = searchText.replacingOccurrences(of: " ", with: "+")
                    weather.performGeocodeRequest(with: newText)
                    withAnimation {
                        changeToPlacesView = false
                    }
                }
            
            Button {
                weather.manager.startUpdatingLocation()
                withAnimation {
                    changeToPlacesView = false
                }
            } label: {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }

        }

    }
    
    
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView(changeToPlacesView: .constant(false))
            .environmentObject(WeatherViewModel.shared)
    }
}





