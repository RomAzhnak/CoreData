//
//  EditToDoView.swift
//  ToDo_CoreData
//
//  Created by Fusion Tech on 21.07.2024.
//

import SwiftUI

struct EditToDoView: View {
    @Binding var todo: ToDo
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var modelContext
    
    @State private var newCommentName = ""
    
//    init(todo: Binding<ToDo>) {
//        _todo = todo
//    }

    var body: some View {
        Form {
            TextField("Name", text: $todo.name)
            TextField("Details", text: $todo.details, axis: .vertical)
            DatePicker("Date", selection: $todo.date)

            Section("Priority") {
                Picker("Priority", selection: $todo.priority) {
                    Text("Low").tag(Int16(1))
                    Text("Mid").tag(Int16(2))
                    Text("High").tag(Int16(3))
                }
                .pickerStyle(.segmented)
            }

            Section("Comments") {
                ForEach((todo.comments?.allObjects as? [Comment] ?? []).sorted { $0.name ?? "" < $1.name ?? "" }) { comment in
                    Text(comment.name ?? "")
                }

                HStack {
                    TextField("Add a new comment in \(todo.name)", text: $newCommentName)

                    Button("Add", action: addComment)
                }
            }
        }
        .navigationTitle("Edit ToDo")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addComment() {
        guard newCommentName.isEmpty == false else { return }

        withAnimation {
            let comment = Comment(context: modelContext)
            comment.name = newCommentName
            comment.todo = todo
            let set: NSMutableSet? = todo.comments as? NSMutableSet
            set?.add(comment)
            todo.comments = set
            newCommentName = ""
        }
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: ToDo.self, configurations: config)
//        let example = ToDo(name: "Example ToDo", details: "Example details go here and will automatically expand vertically as they are edited.")
//        return EditToDoView(todo: example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
