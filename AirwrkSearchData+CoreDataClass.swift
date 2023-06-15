//
//  AirwrkSearchData+CoreDataClass.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/16/23.
//
//

import Foundation
import CoreData


public class AirwrkSearchData: NSManagedObject {
    class func findOrCreate(text : String, in context : NSManagedObjectContext, id : String) throws -> AirwrkSearchData {
        
        let request : NSFetchRequest<AirwrkSearchData> = AirwrkSearchData.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", id)
        request.predicate = predicate
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                return try setOrUpdateData(searchDataDB: matches[0], text: text, id: id, context: context)
            }
        } catch {
            throw error
        }
        let searchDataDB = AirwrkSearchData(context: context)
        return try setOrUpdateData(searchDataDB: searchDataDB, text: text, id: id, context: context)
    }
    
    class func setOrUpdateData(searchDataDB : AirwrkSearchData, text: String, id : String, context : NSManagedObjectContext) throws -> AirwrkSearchData {
        searchDataDB.text = text
        searchDataDB.id = id
        return searchDataDB
    }
    
    class func deleteTextFromDB(id : String, context: NSManagedObjectContext, complition: @escaping () -> ())
    {
        let request : NSFetchRequest<AirwrkSearchData> = AirwrkSearchData.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        do {
            let matches = try context.fetch(request)
            for match in matches {
                context.delete(match)
            }
            try context.save()
        } catch let error {
            print("delete error = \(error.localizedDescription)")
        }
        complition()
    }
    
    class func fetchAllText(context : NSManagedObjectContext)-> [AirwrkSearchData]? {
        let request : NSFetchRequest<AirwrkSearchData> = AirwrkSearchData.fetchRequest()
        do {
            let matches = try context.fetch(request)
            return matches
        } catch let error {
            print("fetching Error = \(error.localizedDescription)")
        }
        return nil
    }
    
}
