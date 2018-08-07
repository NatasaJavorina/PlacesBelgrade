//
//  CoreDataManager.swift
//  PlacesBelgrade
//
//  Created by Natasa Javorina on 8/7/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    func insertPlaces(dictArray: [[String: Any]]) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error.description)
        }
        
        for dict in dictArray {
            
            if let id = dict["id"] as? Int32,
                let name = dict["name"] as? String,
                let address = dict["address"] as? String,
                let city = dict["city"] as? String,
                let placeDescription = dict["description"] as? String,
                let latitude = dict["latitude"] as? Double,
                let longitude = dict["longitude"] as? Double,
                let placeImgUrl = dict["placeImgUrl"] as? String {
                
                let place = Place(context: persistentContainer.viewContext)
                place.id = id
                place.name = name
                place.address = address
                place.city = city
                place.placeDescription = placeDescription
                place.latitude = latitude
                place.longitude = longitude
                place.placeImgUrl = placeImgUrl
            }
            saveContext()
            NotificationCenter.default.post(name: Notification.Name("PlacesUpdateDidFinishNotification"), object: nil)
            
        }
    }
        
    
    func fetchPlaces() -> [Place]? {
        let fetchRequest = NSFetchRequest<Place>(entityName: "Place")
        do {
            let fetchResults = try persistentContainer.viewContext.fetch(fetchRequest)
            return fetchResults
            
        } catch {
            return nil
        }
        
    }
    
    
    // Cut from AppDelegate
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "PlacesBelgrade")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


    

