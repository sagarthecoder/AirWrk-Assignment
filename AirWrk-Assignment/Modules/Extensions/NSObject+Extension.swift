//
//  NSObject+Extension.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/15/23.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: self)
    }
    
    public class var className: String {
        return String(describing: self)
    }
}

