//
//  ListItemView.swift
//  JustList
//
//  Created by Oliver Hu on 7/22/24.
//

import SwiftUI
import SwiftData

struct ListItemView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        List {
            ForEach(items) { item in
                HStack {
                    Text(item.title)
                    Spacer()
                    Image(systemName: item.isChecked ? "checkmark.square" : "square")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(item.isChecked ? .blue : .gray)
                        .onTapGesture {
                            toggleCheck(item)
                        }
                }
            }
            .onDelete(perform: removeItems)
        }
    }

        init(type: String = "All", sortOrder: [SortDescriptor<Item>]) {
            _items = Query(filter: #Predicate {
                if type == "All" {
                    return true
                } else {
                    return $0.type == type
                }
            }, sort: sortOrder)
        }
    
    func toggleCheck(_ selectedItem: Item) {
        if selectedItem.isChecked {
            // Uncheck the item if it is already checked
            if let index = items.firstIndex(where: { $0.id == selectedItem.id }) {
                items[index].isChecked = false
                selectedItem.type = "Unchecked"
            }
        } else {
            // Check the selected item
            if let index = items.firstIndex(where: { $0.id == selectedItem.id }) {
                items[index].isChecked = true
                selectedItem.type = "Checked"
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = items[offset]
            modelContext.delete(item)
        }
    }
}


#Preview {
    ListItemView(sortOrder: [SortDescriptor(\Item.title)])
        .modelContainer(for: Item.self)
}
