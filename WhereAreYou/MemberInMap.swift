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
    var latitude   :CLLocationDegrees
    var longitude  :CLLocationDegrees
    
    init? (name:String, updatedDate:NSDate, latitude:CLLocationDegrees, longitude:CLLocationDegrees) {
        self.name        = name
        self.updatedDate = updatedDate
        self.latitude    = latitude
        self.longitude   = longitude
        
        super.init()
        
        if name.isEmpty  {
            return nil
        }
    }
}