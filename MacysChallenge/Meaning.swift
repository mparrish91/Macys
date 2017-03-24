//
//  Meaning.swift
//  MacysChallenge
//
//  Created by parry on 3/23/17.
//  Copyright © 2017 parry. All rights reserved.
//

import Foundation
import Alamofire

struct Meaning {
    var longForm: String
    var frequency: Int
    var since: Int
}


extension Meaning {
    
    init?(json: [String:Any]) {
        guard let longForm = json["lf"] as? String,
            let frequency = json["freq"] as? Int,
            let since = json["since"] as? Int
            
            else {
                return nil
        }

        self.longForm = longForm
        self.frequency = frequency
        self.since = since
    }
}

extension Meaning {
    
    
    static func retrieveMeanings(_ city: String, completionHandler: @escaping (_ data: [Meaning], _ error: NSError?) -> Void) -> Void {
        
        let resourceUrl = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
        
        Alamofire.request(resourceUrl, parameters: ["sf": city]).responseJSON { response in
            
            var meanings: [Meaning] = []
            
            //access JSON which has an array root
            if let json = response.result.value as? [Any] {
                
                //access encapsulating dictionary
                if let dataSource = json.first as? [String:AnyObject] {
                    
                    //access the "lfs" or long form key which has an array of result objects
                    if let meaningArray = dataSource["lfs"] as? [[String:AnyObject]] {
                        for case let result in meaningArray {
                            if let meaning = Meaning(json: result) {
                                meanings.append(meaning)
                            }
                        }
                    }
                    completionHandler(meanings, nil)
                    
                } else {
                    print("Invalid Input")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "invalidInput"), object: nil)
                    
                }
            }
        }
    }
}
