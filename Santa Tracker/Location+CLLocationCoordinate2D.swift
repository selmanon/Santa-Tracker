//
//  Location+Test.swift
//  Santa Tracker
//
//  Created by Abdellah SELASSI on 12/17/16.
//  Copyright © 2016 Dial. All rights reserved.
//

import MapKit

extension Location {
    var clLocationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
