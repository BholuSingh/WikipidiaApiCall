//
//  CoreDataModel.swift
//  WikipidiaApiCall
//
//  Created by 3Embed on 09/09/18.
//  Copyright © 2018 3Embed. All rights reserved.
//

import UIKit
import CoreData

class CoreDataModel: NSObject {
   
    var people: [NSManagedObject] = []
    var searchData: [NSManagedObject] = []
    
    static var obj:CoreDataModel? = nil
    
    class func sharedInstance() -> CoreDataModel {
        
        if obj == nil {
            
            obj = CoreDataModel()
        }
        
        return obj!
    }
    
    
    
    /// Saving Data To Core Data
    ///
    /// - Parameter searchVCViewM: Search View Model Object
    func saveData(searchVCViewM: SearchVCViewModel) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        fetchFromCoreData()
        var managedContext: NSManagedObjectContext!
        managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entityData =
            NSEntityDescription.entity(forEntityName: "SearchData",
                                       in: managedContext)!
        
        let searchD = NSManagedObject(entity: entityData,
                                      insertInto: managedContext)
        if searchVCViewM.getTotallNumOfCells() > 0 {
            for index in 0...(searchVCViewM.getTotallNumOfCells() - 1) {
                if people.count > 1 {
                    if searchForParticularData(tittleS: searchVCViewM.getTittle(index: index)) {
                        if searchVCViewM.getTittle(index: index).count == 0 {
                            break
                        }
                        searchD.setValue( searchVCViewM.getTittle(index: index) , forKeyPath: "tittle")
                        searchD.setValue( searchVCViewM.getmainUrl(index: index) , forKeyPath: "mainUrl")
                        searchD.setValue( searchVCViewM.getImageUrl(index: index) , forKeyPath: "imageUrl")
                        searchD.setValue( searchVCViewM.getDiscription(index: index) , forKeyPath: "discription")
                        do {
                            try managedContext.save()
                        } catch let error as NSError {
                            print("Could not save. \(error), \(error.userInfo)")
                        }
                    }
                }else {
                    searchD.setValue( searchVCViewM.getTittle(index: index) , forKeyPath: "tittle")
                    searchD.setValue( searchVCViewM.getmainUrl(index: index) , forKeyPath: "mainUrl")
                    searchD.setValue( searchVCViewM.getImageUrl(index: index) , forKeyPath: "imageUrl")
                    searchD.setValue( searchVCViewM.getDiscription(index: index) , forKeyPath: "discription")
                    do {
                        try managedContext.save()
                        //                    people.append(searchD)
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }
        
        
    }
    
    
    /// fetch data From Core Data
    func fetchFromCoreData() {
        people.removeAll()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        var managedContext: NSManagedObjectContext!
        managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "SearchData")
        
        do {
            people = try managedContext.fetch(fetchRequest)
           
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}


// MARK: - Search Data
extension CoreDataModel {
    
    /// Search tittle in Core dataBase
    ///
    /// - Parameter tittleS: tittle of search Field
    /// - Returns: return the Bool Value
    func searchForParticularData(tittleS: String)-> Bool {
        var count = 0
        for index in 0...(people.count - 1) {
            count += 1
            if people[index].value(forKeyPath: "tittle") != nil {
                let serTittle = GenericUtility.strForObj(object: people[index].value(forKeyPath: "tittle")!)
                if serTittle.lowercased() == tittleS.lowercased() {
                    return false
                }
            }else {
                continue
            }
        }
        return true
    }
    
    /// get all search Data Count
    ///
    /// - Returns: count of the array
    func getSearchDataCount() -> Int {
        return searchData.count
    }
    
    /// search the searched String in core data
    ///
    /// - Parameters:
    ///   - searchtext: search text in search View
    ///   - complitionHandler: tells that searchj has been finished
    func searchDataForSearchString(searchtext: String, complitionHandler: @escaping((Bool)-> Void)) {
        searchData.removeAll()
        var count = 0
        for index in 0...(people.count - 1) {
            count += 1
            if people[index].value(forKeyPath: "tittle") != nil {
                let serTittle = GenericUtility.strForObj(object: people[index].value(forKeyPath: "tittle")!)
                if serTittle.lowercased().contains(searchtext.lowercased().replacingOccurrences(of: "+", with: " ")) {
                    searchData.append(people[index])
                }
            }else {
                continue
            }
            if people.count == count {
                complitionHandler(true)
            }
        }
    }
    
    /// Get Tittle
    ///
    /// - Parameter index: index path
    /// - Returns: tittle
    func getTittle(index: Int) -> String{
        return  GenericUtility.strForObj(object: searchData[index].value(forKeyPath: "tittle")!)
    }
    
    /// get image Url
    ///
    /// - Parameter index: index path
    /// - Returns: image Url
    func getimageUrl(index: Int) -> String{
        return  GenericUtility.strForObj(object: searchData[index].value(forKeyPath: "imageUrl")!)
    }
    
    /// get the main Url
    ///
    /// - Parameter index: index path
    /// - Returns: main Url
    func getmainUrl(index: Int) -> String{
        return  GenericUtility.strForObj(object: searchData[index].value(forKeyPath: "mainUrl")!)
    }
    
    /// get the discription
    ///
    /// - Parameter index: index path
    /// - Returns: return the discription
    func getDiscription(index: Int) -> String{
        return  GenericUtility.strForObj(object: searchData[index].value(forKeyPath: "discription")!)
    }
    
    

}
