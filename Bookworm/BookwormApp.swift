//
//  BookwormApp.swift
//  Bookworm
//
//  Created by KhoiLe on 03/07/2021.
//

import SwiftUI
import CoreData

@main
struct BookwormApp: App {
    let persistenceContainer = PersistenceController.shared // <- so need add this line

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext) // <- and here <-
        }
    }
}

