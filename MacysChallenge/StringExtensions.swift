//
//  StringExtensions.swift
//  MacysChallenge
//
//  Created by parry on 3/23/17.
//  Copyright © 2017 parry. All rights reserved.
//

import Foundation


extension String {
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
}
