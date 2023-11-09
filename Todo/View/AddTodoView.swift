//
//  AddTodoView.swift
//  Todo App
//
//  Created by Christos Eteoglou on 2023-11-08.
//

import SwiftUI
import CoreData

struct AddTodoView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var name = ""
    @State private var priority = "Normal"

    let priorities = ["High", "Normal", "Low"]
    
    @State private var isAlertShowing = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 9))
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button {
                        withAnimation {
                            if self.name != "" {
                                let todo = Todo(context: self.managedObjectContext)
                                todo.name = self.name
                                todo.priority = self.priority
                                do {
                                    try managedObjectContext.save()
                                    // print("New todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
                                    dismiss()
                                } catch {
                                    print(error)
                                }
                            } else {
                                self.isAlertShowing = true
                                self.errorTitle = "Invalid Name"
                                self.errorMessage = "Make sure to enter something for\nthe new todo item."
                                return
                            }
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 9))
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
            }
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .alert(isPresented: $isAlertShowing) {
                Alert(
                    title: Text(errorTitle),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

// MARK: - PREVIEW

#Preview {
    AddTodoView()
}
