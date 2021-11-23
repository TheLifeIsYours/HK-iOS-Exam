import Foundation
import CoreData

final class PersistenceProvider {
    enum StoreType {
        case inMemory, persisted
    }
    
    var url: URL {
        let bundle = Bundle(for: PersistenceProvider.self)
        
        guard let url = bundle.url(forResource: "FolioUserStorage", withExtension: "momd") else {
            fatalError("Failed to locate momd file for Folio")
        }
        
        return url
    }
    
    static var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: PersistenceProvider.self)
        
        guard let url = bundle.url(forResource: "FolioUserStorage", withExtension: "momd") else {
            fatalError("Failed to locate momd file for Folio")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load momd file for Folio")
        }
        
        return model
    }()
    
    var persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    static let `default`: PersistenceProvider = PersistenceProvider()
    
    init(storeType: StoreType = .persisted) {
        persistentContainer = NSPersistentContainer(name: "Folio", managedObjectModel: Self.managedObjectModel)
        
        if storeType == .inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed loading persistent stores with error: \(error.localizedDescription)")
            }
        }
    }
    
    func clearPersistentStore() {
        let storeContainer = persistentContainer.persistentStoreCoordinator
        
        do {
            for store in storeContainer.persistentStores {
                try storeContainer.destroyPersistentStore(
                    at: store.url!,
                    ofType: store.type,
                    options: nil
                )
            }
        } catch {
            debugPrint(error)
        }

        persistentContainer = NSPersistentContainer(
            name: "FolioUserStorage"
        )

        persistentContainer.loadPersistentStores { (store, error) in
            debugPrint(store)
            
            if let error = error {
                fatalError("Failed clear persistent stores with error: \(error.localizedDescription)")
            }
        }
    }
}
