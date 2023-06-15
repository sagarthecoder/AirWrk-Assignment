//
//  NSContextManager.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/16/23.
//

import UIKit
import CoreData

class NSContextManager: NSObject {
    private override init() {}
    
    static let shared = NSContextManager()
   
    func getContext() -> NSManagedObjectContext? {
        let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        return container?.viewContext
    }
}

