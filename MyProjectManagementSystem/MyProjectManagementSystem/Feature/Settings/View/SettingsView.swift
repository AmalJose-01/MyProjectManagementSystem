//
//  SettingsView.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("accentColor") private var accentColorName: String = "system"
    @State private var selectedColorName: String = "system"
    
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme  // Detect system light/dark mode
    
    // Define colors for customization
    let colors: [String: Color] = [
        "Lite": .white,
        "blue": .blue,
        "red": .red,
        "green": .green,
        "yellow": .yellow,
        "purple": .purple,
        "orange": .orange
    ]
    
    var body: some View {
        VStack {
            Text("Choose Accent Color")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary) // Adjusts for light/dark mode
                .padding(.top, 50)
            
            Spacer()
            
            // Scrollable Color Picker
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    // System Color Option (Dynamic)
                    VStack {
                        Circle()
                            .fill(colorScheme == .dark ? .white : .black) // Adaptive system color
                            .frame(width: 70, height: 70)
                            .shadow(radius: 5)
                            .scaleEffect(selectedColorName == "system" ? 1.2 : 1.0)
                            .animation(.spring(), value: selectedColorName)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .opacity(selectedColorName == "system" ? 1 : 0)
                            )
                            .onTapGesture {
                                withAnimation {
                                    selectedColorName = "system"
                                    accentColorName = "system"
                                    themeManager.accentColorName = "system"
                                }
                            }
                        
                        Text("System")
                            .foregroundColor(.primary)
                            .font(.caption)
                    }
                    
                    // Loop through color options
                    ForEach(colors.keys.sorted(), id: \.self) { colorName in
                        VStack {
                            Circle()
                                .fill(colors[colorName] ?? .blue)
                                .frame(width: 70, height: 70)
                                .shadow(radius: 5)
                                .scaleEffect(selectedColorName == colorName ? 1.2 : 1.0)
                                .animation(.spring(), value: selectedColorName)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 4)
                                        .opacity(selectedColorName == colorName ? 1 : 0)
                                )
                                .onTapGesture {
                                    withAnimation {
                                        selectedColorName = colorName
                                        accentColorName = colorName
                                        themeManager.accentColorName = colorName
                                    }
                                }
                            
                            Text(colorName.capitalized)
                                .foregroundColor(.primary)
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
            
          
            
        }
        .padding()
        .background(colorScheme == .dark ? Color.black : Color.white) // Adaptive background
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if accentColorName == "system" {
                selectedColorName = "system"
            }
        }
    }
}

