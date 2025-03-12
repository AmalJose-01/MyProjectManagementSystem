//
//  ThemeManager.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var accentColorName: String = "system" {
        didSet {
            // Whenever the accent color is updated, notify views.
        }
    }
    
    let colors: [String: Color] = [
        "Lite": .white,
        "blue": .blue,
        "red": .red,
        "green": .green,
        "yellow": .yellow,
        "purple": .purple,
        "orange": .orange
    ]
    
    var accentColor: Color {
        colors[accentColorName] ?? .accentColor // Return system color if no color is selected
    }
}
