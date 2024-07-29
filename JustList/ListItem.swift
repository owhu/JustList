//
//  ListItem.swift
//  JustList
//
//  Created by Oliver Hu on 7/22/24.
//

import SwiftUI
import SwiftData

@Model
class Item: Identifiable {
    let id: UUID
    var title: String
    var isChecked: Bool
    var type: String

    init(title: String, isChecked: Bool = false, type: String) {
        self.id = UUID()
        self.title = title
        self.isChecked = isChecked
        self.type = type
    }
}
