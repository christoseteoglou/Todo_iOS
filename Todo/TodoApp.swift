//
//  TodoApp.swift
//  Todo
//
//  Created by Christos Eteoglou on 2023-11-08.
//

import SwiftUI

@main
struct TodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
