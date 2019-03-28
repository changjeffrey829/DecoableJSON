//
//  StringExt.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 3/24/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}
