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
    
    //static allows us to read externally
    static let types = ["Checked", "Unchecked"]
    

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
            
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
        }
    }
}

#Preview {
    AddView()
        .modelContainer(for: Item.self)
}
