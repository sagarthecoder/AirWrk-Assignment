//
//  AirwrkSearchData+CoreDataProperties.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/16/23.
//
//

import Foundation
import CoreData


extension AirwrkSearchData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AirwrkSearchData> {
        return NSFetchRequest<AirwrkSearchData>(entityName: "AirwrkSearchData")
    }

    @NSManaged public var id: String?
    @NSManaged public var text: String?

}

extension AirwrkSearchData : Identifiable {

}
