//
//  PersistentController.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//


import Foundation
import CoreData

enum EntityName: String {
    case storedModel = "StoredModel"
}

class PersistentController {
    let containerName: String
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var newBackgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.containerName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    init(containerName: String ) {
        self.containerName = containerName
    }

    func saveViewContext() {
        saveContext(persistentContainer.viewContext)
    }

    func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
                viewContext.refreshAllObjects()
            } catch {
                let nserror = error as NSError
                print(nserror)
                print(nserror.userInfo)            }
        }
    }

    func eraseEntity(_ name: EntityName) {
        let context = viewContext
        let requestToDelete = NSFetchRequest<NSFetchRequestResult>(entityName: name.rawValue)
        let batchDelete = NSBatchDeleteRequest(fetchRequest: requestToDelete)
        do {
            try context.execute(batchDelete)
            try context.save()
        } catch {
            print("Error while erasing data DataManager row 134")
        }
        saveViewContext()
    }

}
