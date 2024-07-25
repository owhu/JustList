//
//  JustListApp.swift
//  JustList
//
//  Created by Oliver Hu on 6/27/24.
//

import SwiftUI
import SwiftData

@main
struct JustListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
