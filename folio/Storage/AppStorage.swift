//
//  AppStorage.swift
//  folio
//
//  Created by Mats Daniel Larsen on 12/11/2021.
//

import Foundation
import CoreData

public class AppStorage: NSManagedObject {
    @NSManaged var seed: String
}

extension AppStorage {
    static func getSeed() -> String {
        var result = "ios"
        
        do {
            let context = PersistenceProvider().persistentContainer.viewContext
            let request = AppStorage.fetchRequest()
            
            request.sortDescriptors = []
            
            result = try context.fetch(request).first?.seed ?? "ios"
        } catch {
            debugPrint("Error while getFolio: \(error)")
        }
        
        return result
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppStorage> {
        return NSFetchRequest<AppStorage>(entityName: "AppStorage")
    }
}
