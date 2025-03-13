//
//  EmptyStateView.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 13/3/2025.
//

import SwiftUI

struct EmptyStateView: View {
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Illustration
            Image(systemName: "checklist")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue.opacity(0.8))
                .symbolRenderingMode(.hierarchical)
            
            // Motivational Message
            Text("No tasks added yet!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Stay organized and boost productivity. Start by adding your first task!")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
 
        }
        .padding()
    }
}
