//
//  Folio.swift
//  folio
//
//  Created by Mats Daniel Larsen on 08/11/2021.
//

import Foundation
import CoreData
import ObjectMapper

public class Folio: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var email: String
    @NSManaged var date: Date
    @NSManaged var age: Int
    @NSManaged var phone: String
    @NSManaged var pictureLarge: String
    @NSManaged var pictureMedium: String
    @NSManaged var pictureThumbnail: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    
    //None API attributes
    @NSManaged var removed: Bool
    @NSManaged var edited: Bool
    @NSManaged var seed: String
}

extension Folio {
    static func getAllFolios(context: NSManagedObjectContext) -> [Folio]? {
        var result: [Folio]?
        
        do {
            let request = Folio.fetchRequest()
            
            let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            request.returnsObjectsAsFaults = false
            
            result = try context.fetch(request)
        } catch {
            debugPrint("Error while getFolio: \(error)")
        }
        
        return result
    }
    
    static func getFolio(where id: String, context: NSManagedObjectContext) -> Folio? {
        var result: Folio?
        
        print("Should be ID: \(id)")
        
        do {
            let context = PersistenceProvider().persistentContainer.viewContext
            let request = Folio.fetchRequest()
            request.returnsObjectsAsFaults = false
            
            print(id)
            request.predicate = NSPredicate(format: "id == %@", id)
            
            result = try context.fetch(request).first
        } catch {
            debugPrint("Error while getFolio: \(error)")
        }
        
        return result
    }
    
    static func storeFolio(person: Person, seed: String, context: NSManagedObjectContext) {
        let folio = Folio(context: context)

        folio.id = person.id!.value!

        folio.firstName = person.name!.first!
        folio.lastName = person.name!.last!
        folio.phone = person.phone!
        folio.email = person.email!
        folio.city = person.location!.city!
        folio.state = person.location!.state!
        folio.latitude = person.location!.coordinates!.latitude!
        folio.longitude = person.location!.coordinates!.longitude!
        folio.date = person.dateOfBirth!.date!
        folio.age = person.dateOfBirth!.age!
        folio.pictureLarge = person.picture!.large!
        folio.pictureMedium = person.picture!.medium!
        folio.pictureThumbnail = person.picture!.thumbnail!
        
        //None API attributes
        folio.seed = seed
        
        do {
            try context.save()
        } catch {
            debugPrint("Error while storing person as folio: \(error)")
        }
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folio> {
        return NSFetchRequest<Folio>(entityName: "Folio")
    }
}

class FolioObserver: ObservableObject {
    @Published var context: NSManagedObjectContext?
    @Published var folio: Folio?
    @Published var folios: [Folio]?
    
    init(){}
    
    func observeAllFolios() {
        self.folios = Folio.getAllFolios(context: context!)
    }
    
    func observeFolio(by id: String) {
        print("Should be ID: \(id)")
        
        self.folio = Folio.getFolio(where: id, context: context!)
    }
}
