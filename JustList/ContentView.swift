//
//  ContentView.swift
//  JustList
//
//  Created by Oliver Hu on 6/27/24.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var items: [Item]
    @State private var showingAddItem = false
    @State private var sortOrder = [
        SortDescriptor(\Item.title),
    ]
    @State private var itemType = "All"
    @State private var showingAlert = false
    
    
    var body: some View {
        NavigationStack {
            ListItemView(type: itemType, sortOrder: sortOrder)
                .toolbar {
                    //                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Item", systemImage: "plus") {
                        showingAddItem = true
                    }
                    //                }
                    
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter", selection: $itemType) {
                            Text("Show All Items")
                                .tag("All")
                            
                            Divider()
                            
                            ForEach(AddView.types, id: \.self) { type in
                                Text(type)
                                    .tag(type)
                            }
                        }
                    }
                    
//                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
//                        Picker("Sort", selection: $sortOrder) {
//                            Text("Sort by Name A-Z")
//                                .tag([SortDescriptor(\Item.title)
//                                     ])
//                            Text("Sort by Name Z-A")
//                                .tag([SortDescriptor(\Item.title, order: .reverse)
//                                     ])
//                        }
//                    }
                    
                    Button("Uncheck All Items", systemImage: "checkmark.circle.badge.xmark") {
                        for item in items {
                            item.isChecked = false
                            item.type = "Unchecked"
                        }
                    }
                    
                    Button("Empty List", systemImage: "trash") {
                        showingAlert = true
                    }
                    .alert("Delete all items?", isPresented: $showingAlert) {
                        Button("OK", role: .destructive) {
                            for item in items {
                                modelContext.delete(item)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingAddItem) {
                    AddView()
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self)
}

