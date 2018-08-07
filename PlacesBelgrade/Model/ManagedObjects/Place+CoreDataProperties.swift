//
//  Place+CoreDataProperties.swift
//  PlacesBelgrade
//
//  Created by Natasa Javorina on 8/7/18.
//  Copyright © 2018 javorina. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit

extension Place: MKAnnotation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var id: Int32
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var placeDescription: String?
    @NSManaged public var placeImgUrl: String?

    public var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    // Title and subtitle for use by selection UI.
    public var title: String? {
        get {
            return name
        }
    }
    
    public var subtitle: String? {
        get {
            return address
        }
    }
}
