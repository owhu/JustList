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
    
    @State private var showingAddItem = false
    
    var body: some View {
        ZStack {
            VStack {
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
                
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            showingAddItem = true
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 15, height: 15)
                                .padding(10)

                                .background {
                                    Color.secondary
                                        .cornerRadius(5.0)
                                        .shadow(color: .gray, radius:40, x: 0.0, y: 0.0)
                                }
                        }
                        .padding()
                    }
                    .padding()
                }
                .sheet(isPresented: $showingAddItem) {
                    AddView()
                }
    
            }
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
