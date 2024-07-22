//
//  ToDoListingView.swift
//  ToDo_CoreData
//
//  Created by Fusion Tech on 21.07.2024.
//

import SwiftUI

struct ToDoListingView: View {
    @Environment(\.managedObjectContext) var modelContext
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\ToDo.priority, order: .reverse),
        SortDescriptor(\ToDo.name)
    ]) var todos: FetchedResults<ToDo>
        
    init(sort: SortDescriptor<ToDo>, searchString: String) {
        let searchPredicate = searchString == "" ? nil : NSPredicate(format: "name CONTAINS[c] %@", searchString)
        _todos = FetchRequest(
            sortDescriptors: [sort, SortDescriptor(\ToDo.name)],
            predicate: searchPredicate
        )
    }

    var body: some View {
        List {
            ForEach(todos) { todo in
                NavigationLink(value: todo) {
                    VStack(alignment: .leading) {
                        Text(todo.name)
                            .font(.headline)

                        Text(todo.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteToDos)
        }
    }

    func deleteToDos(_ indexSet: IndexSet) {
        for index in indexSet {
            let todo = todos[index]
            modelContext.delete(todo)
        }
        PersistenceController.shared.save()
    }
}

#Preview {
    ToDoListingView(sort: SortDescriptor(\ToDo.name), searchString: "")
}
