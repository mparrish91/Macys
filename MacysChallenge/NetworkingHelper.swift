//
//  NetworkingHelper.swift
//  MacysChallenge
//
//  Created by parry on 3/22/17.
//  Copyright © 2017 parry. All rights reserved.
//
import Foundation
import Alamofire

private let params = ["sf": "HMM"]
private let resourceUrl = "http://www.nactem.ac.uk/software/acromine/dictionary.py"


final class NetworkingHelper: NSObject {
    
    static let sharedInstance = NetworkingHelper()
    
    func retrieve(_ city: String, completionHandler: @escaping (_ data: [MeaningObject], _ error: NSError?) -> Void) -> Void {
        
        Alamofire.request(resourceUrl, parameters: params).responseJSON { response in
            
            var objectArray = [MeaningObject]()
            
            //access JSON with array root
            //access the "lfs" or long form key which has an array of result objects
            if let json = response.result.value as? [Any] {
                
                //access encapsulating dictionary
                let dataSource = json.first as? [String:AnyObject]
                
                //access the "lfs" or long form key which has an array of result objects
                if let meaningArray = dataSource?["lfs"] as? [[String:AnyObject]] {
                    for dic in meaningArray {
                        let newResponseObject = MeaningObject(dictionary: dic)
                        objectArray.append(newResponseObject)
                    }
                }
            }
        }
        
    }
}
