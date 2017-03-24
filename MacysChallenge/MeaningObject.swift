//
//  MeaningObject.swift
//  MacysChallenge
//
//  Created by parry on 3/23/17.
//  Copyright © 2017 parry. All rights reserved.
//

import Foundation


final class MeaningObject: NSObject {
    
    var shortForm: String?
    var longForm: String?
    var frequency: String?
    var since: String?

    
    init(dictionary: [String:AnyObject]) {
        super.init()
        
        shortForm = dictionary["high"] as? String
        longForm = dictionary["low"] as? String
    
    }
    
}
