//
//  Persistence.swift
//  Bookworm
//
//  Created by KhoiLe on 03/07/2021.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        //name of the project
        container = NSPersistentContainer(name: "Bookworm")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolve Error: \(error)")
            }
        })
    }
}
