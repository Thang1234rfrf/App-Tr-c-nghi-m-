import UIKit
import CoreData

class DataController {
    static let shared = DataController()
    private init() {}

    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name:"AppTracNgiem")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func fetchData() -> [DeThiGdcd] {
        let fetchRequest: NSFetchRequest<DeThiGdcd> = DeThiGdcd.fetchRequest() as! NSFetchRequest<DeThiGdcd>
        do {
            let items = try managedObjectContext.fetch(fetchRequest)
            return items
        } catch {
            print("Fetch failed")
            return []
        }
    }
}
