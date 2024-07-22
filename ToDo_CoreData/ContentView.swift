//
//  ContentView.swift
//  ToDo_CoreData
//
//  Created by Fusion Tech on 19.07.2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var modelContext

    @State private var path = [ToDo]()
    @State private var sortOrder = SortDescriptor(\ToDo.priority, order: .reverse)
    @State private var searchText = ""

    var body: some View {
        NavigationStack(path: $path) {
            ToDoListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("ToDo")
                .navigationDestination(for: ToDo.self) { todo in EditToDoView(todo: .constant(todo)) }
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add ToDo", systemImage: "plus", action: addToDo)

                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\ToDo.name))

                            Text("Priority")
                                .tag(SortDescriptor(\ToDo.priority, order: .reverse))

                            Text("Date")
                                .tag(SortDescriptor(\ToDo.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }

    func addToDo() {
        let todo = ToDo(context: modelContext)
        todo.name = ""
        todo.details = ""
        todo.date = Date()
        todo.priority = 2
        path = [todo]
    }
}

#Preview {
    ContentView()
}
