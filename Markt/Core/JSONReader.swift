//
//  JSONReader.swift
//  Markt
//
//  Created by Davit Ghushchyan on 06.05.25.
//

import Foundation

extension Bundle {
    static func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
