//
//  ContentView.swift
//  Todo
//
//  Created by Christos Eteoglou on 2023-11-08.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddTodoView = false
    @State private var isAnimating = false
    @State private var isSettingsShowing = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos:
    FetchedResults<Todo>
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
                        }
                    }
                    .onDelete(perform: deleteTodo)
                }
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            self.isSettingsShowing.toggle()
                        } label: {
                            Image(systemName: "paintbrush")
                        }
                        .sheet(isPresented: $isSettingsShowing, content: {
                            SettingsView()
                        })
                    }
                }
                if todos.count == 0 {
                    EmptyListView()
                }
            }
            .sheet(isPresented: $showingAddTodoView, content: {
                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            })
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.isAnimating ? 0.2 : 0)
                            .scaleEffect(self.isAnimating ? 1.1 : 1)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.isAnimating ? 0.15 : 0)
                            .scaleEffect(self.isAnimating ? 1.1 : 1)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    
                    Button {
                        self.showingAddTodoView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("Colorbase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    }
                    .onAppear(perform: {
                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            self.isAnimating.toggle()
                        }
                    })
                }
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
        }
    }
    
    // MARK: - FUNCTIONS
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
