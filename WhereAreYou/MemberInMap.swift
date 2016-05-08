//
//  MemberInMap.swift
//  WhereAreYou
//
//  Created by Jang Hyeon Lee on 2016. 5. 8..
//  Copyright © 2016년 Jang Hyeon Lee. All rights reserved.
//

import Foundation
import CoreLocation

class MemberInMap:NSObject {
    var name       :String
    var updatedDate:NSDate
    var longitude  :CLLocationDegrees
    var latitude   :CLLocationDegrees
    
    init? (name:String, updatedDate:NSDate, longitude:CLLocationDegrees, latitude:CLLocationDegrees) {
        self.name        = name
        self.updatedDate = updatedDate
        self.longitude   = longitude
        self.latitude    = latitude
        
        super.init()
        
        if name.isEmpty  {
            return nil
        }
    }
}