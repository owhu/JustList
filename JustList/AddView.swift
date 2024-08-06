//
//  AddView.swift
//  JustList
//
//  Created by Oliver Hu on 7/22/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var type = "Unchecked"
    @State private var checked = false
    
    @FocusState private var nameFieldIsFocused: Bool
    
    //static allows us to read externally
    static let types = ["Checked", "Unchecked"]
    

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                    .focused($nameFieldIsFocused)
            }
            .navigationTitle("Add new item")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = Item(title: title, isChecked: false, type: type)
                        modelContext.insert(item)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Automatically focus the text field when the view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    nameFieldIsFocused = true
                }
            }
            .onSubmit {
                let item = Item(title: title, isChecked: false, type: type)
                modelContext.insert(item)
                dismiss()
            }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.white)
//        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
//        .shadow(radius: 20)
//        .frame(height: UIScreen.main.bounds.height / 4.5)
    }
}

#Preview {
    AddView()
        .modelContainer(for: Item.self)
}
