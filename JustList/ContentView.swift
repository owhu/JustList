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
    

    var body: some View {
        NavigationStack {
            ListItemView()
            .navigationTitle("Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Item", systemImage: "plus") {
                        showingAddItem = true
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
}

