//
//  StorageService.swift
//  Markt
//
//  Created by Davit Ghushchyan on 06.05.25.
//

import Foundation

protocol StorageInteractor {
    func store<T: Codable>(model: T, key: String)
    func get<T: Codable>(key: String) -> T?
    func remove(key: String)
}

class StorageService: StorageInteractor {
    
    func store<T: Codable>(model: T, key: String) {
        
    }
    
    func get<T: Codable>(key: String) -> T? {
        return nil
    }
    
    func remove(key: String) {
        
    }
}
