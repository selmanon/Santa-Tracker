//
//  Stop.swift
//  Santa Tracker
//
//  Created by Abdellah SELASSI on 12/17/16.
//  Copyright © 2016 Dial. All rights reserved.
//

import Foundation
import RealmSwift

class Stop: Object {
    dynamic var location: Location?
    dynamic var time: Date = Date(timeIntervalSinceReferenceDate: 0)
    
    convenience init(location: Location, time: Date) {
        self.init()
        self.location = location
        self.time = time
    }
}
