import Foundation
import CoreData

class CoreDataStack: NSObject {

    private(set) var persistentContainer: NSPersistentContainer = AppDelegate.standard.persistentContainer

    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError

                #if DEVELOPMENT
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                #endif

                print ("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
