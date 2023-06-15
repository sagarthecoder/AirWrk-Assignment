//
//  HomePagePresenter.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/16/23.
//

import UIKit

class HomePagePresenter {
    var dbData = [AirwrkSearchData]()
    init() {
        resetCachingTexts()
    }
    
    func resetCachingTexts() {
        dbData = []
        if let context = NSContextManager.shared.getContext() {
            guard let textInfos = AirwrkSearchData.fetchAllText(context: context) else {
                dbData = []
                return
            }
            dbData = textInfos.reversed()
        }
    }
    
    func maxCacheTextLImit()-> Int {
        return 10
    }
    
    func indexValidation(index : Int)-> Bool {
        guard index >= 0, index < dbData.count else {
            return false
        }
        return true
    }
    
    func numberOfCachedText()-> Int {
        return dbData.count
    }
    
    func getCachedSearchTexts()-> [AirwrkSearchData] {
        return dbData
    }
    
    func getItemAt(index : Int)-> AirwrkSearchData? {
        guard indexValidation(index: index) else {
            return nil
        }
        return dbData[index]
    }
    
    func isExist(text : String)-> Bool {
        for data in dbData {
            if let dbtext = data.text?.lowercased(), text.lowercased() == dbtext {
                return true
            }
        }
        return false
    }
    
    func saveNewTextToDB(text : String) {
        if !isExist(text: text), let context = NSContextManager.shared.getContext() {
            
            let _ = try? AirwrkSearchData.findOrCreate(text: text, in: context, id: UUID().uuidString)
            do {
                try context.save()
                self.resetCachingTexts()
            } catch let error {
                print("GM myGIF Saving Error = \(error.localizedDescription)")
            }
            
        }
    }
    
    func deleteTextFromDB(id : String, completion : @escaping ()->Void) {
        if let context = NSContextManager.shared.getContext() {
            do {
                let _ = try? AirwrkSearchData.deleteTextFromDB(id: id, context: context, complition: {
                    self.resetCachingTexts()
                    completion()
                })
            } catch {
                completion()
            }
        }
    }
}
