//
//  StorageService.swift
//  Markt
//
//  Created by Davit Ghushchyan on 06.05.25.
//

import Foundation
import CoreData

protocol StorageInteractor {
    func store<T: Codable>(model: T, key: String)
    func get<T: Codable>(key: String) -> T?
    func remove(key: String)
}

class StorageService: StorageInteractor {
    static var STORAGENAME = "Storage"
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    private var persistentController = PersistentController(containerName: StorageService.STORAGENAME)

    func store<T: Codable>(model: T, key: String) {
        let data = try? encoder.encode(model)
        if let object = getFromDB(key: getKeyFor(key)) {
            object.data = data
        } else {
            let context = persistentController.viewContext
            let object = StoredModel(context: context)
            object.key = getKeyFor(key)
            object.data = data
        }

        persistentController.saveViewContext()
    }

    func get<T: Codable>(key: String) -> T? {

        guard let object = getFromDB(key: getKeyFor(key)) else {
            return nil
        }
        if  object.data != nil {
            guard let model = try? decoder.decode(T.self, from: object.data!) else {
                return nil
            }
            return model
        }
        return nil
    }
    
    func remove(key: String) {
        let context = persistentController.viewContext
        guard let model = getFromDB(key: key) else { return }
        context.delete(model)
        persistentController.saveViewContext()
    }

    private func getFromDB(key: String) -> StoredModel? {
        let context = persistentController.viewContext
        let request: NSFetchRequest<StoredModel> = StoredModel.fetchRequest()

        request.predicate = NSPredicate(format: "key ==[cd] %@", key)
         let object = try? context.fetch(request)
        return object?.first
    }

    private func getKeyFor(_ key: String) -> String {
        return key
    }

}
