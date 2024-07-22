//
//  PersistenceController.swift
//  ToDo_CoreData
//
//  Created by Fusion Tech on 21.07.2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        for i in 0..<10 {
            let todo = ToDo(context: controller.container.viewContext)
            todo.name = "Example \(i)"
            todo.details = "Detaials \(i)"
            todo.date = Date()
            todo.priority = Int16(Int.random(in: 1...3))
        }

        return controller
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ToDo")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}
