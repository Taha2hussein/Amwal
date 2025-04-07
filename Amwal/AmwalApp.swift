//
//  AmwalApp.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import SwiftUI

@main
struct AmwalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
