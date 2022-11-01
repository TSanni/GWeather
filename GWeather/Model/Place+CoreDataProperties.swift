//
//  Place+CoreDataProperties.swift
//  GWeather
//
//  Created by Tomas Sanni on 10/8/22.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var temp: String?
    @NSManaged public var icon: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var timeAdded: Date?
    
    
    public var wrappedName: String {
        name ?? "Unknown location"
    }
    
    public var wrappedDate: String {
        date ?? "January 1, 2000"
    }
    
    public var wrappedTemp: String {
        temp ?? "100"
    }
    
    public var wrappedIcon: String {
        icon ?? "sun.min"
    }
    
    public var wrappedLatitude: Double {
        latitude
    }
    
    public var wrappedLongitude: Double {
        longitude
    }
    
    public var wrappedTimeAdded: Date {
        timeAdded ?? Date.now
    }

}

extension Place : Identifiable {

}
