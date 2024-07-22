//
//  ToDo_CoreDataApp.swift
//  ToDo_CoreData
//
//  Created by Fusion Tech on 19.07.2024.
//

import SwiftUI

@main
struct ToDo_CoreDataApp: App {
    @Environment(\.scenePhase) var scenePhase
//    @StateObject private var dataController = DataController()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
