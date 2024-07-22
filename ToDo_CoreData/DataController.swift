//
//  DataController.swift
//  ToDo_CoreData
//
//  Created by Fusion Tech on 21.07.2024.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ToDo")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
