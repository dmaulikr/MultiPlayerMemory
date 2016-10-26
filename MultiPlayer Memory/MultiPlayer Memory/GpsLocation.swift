//
//  GpsLocation.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-20.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import CoreLocation
import UIKit

struct GeoKey {
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let radius = "radius"
    static let identifier = "identifier"
    static let eventType = "eventType"
}

enum EventType: String {
    case onEntry = "On Entry"
    case onExit = "On Exit"
}

class GpsLocation {
    
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String
    var eventType: EventType
    var inside : Bool
    var warnLabel : UILabel?
    
    static var sharedInstance : GpsLocation = {
        let instance = GpsLocation()
        return instance
    }()
    
    private init() {
        self.coordinate = CLLocationCoordinate2D()
        self.coordinate.latitude = 57.6946
        self.coordinate.longitude = 11.9895
        self.radius = 50
        self.identifier = "WCM"
        self.eventType = EventType.onEntry
        self.inside = false
    }
}

