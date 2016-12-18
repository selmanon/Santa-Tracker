//
//  Santa+Test.swift
//  Santa Tracker
//
//  Created by Abdellah SELASSI on 12/17/16.
//  Copyright © 2016 Dial. All rights reserved.
//

import Foundation

extension Santa {
    static func test() -> Santa {
        let santa = Santa()
        santa.currentLocation = Location(latitude: 37.7749, longitude: -122.4194)
        santa.activity = .deliveringPresents
        santa.presentsRemaining = 42
        return santa    }
}
