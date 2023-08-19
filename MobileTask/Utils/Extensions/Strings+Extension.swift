//
//  Strings+Extension.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

extension String {
    var isValidString: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
    
    var isValidEmail: Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let results = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
            
            if results.count == 0 {
                returnValue = false
            }
            
        } catch _ as NSError {
            returnValue = false
        }
        
        return  returnValue
    }
    
    var isValidPassword: Bool {
        return count >= 6
    }
}
