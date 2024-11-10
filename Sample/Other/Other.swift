//
//  LoadImage.swift
//  Sample
//
//  Created by User on 10/11/24.
//

import SwiftUI

func loadImageFromURL(url: URL) -> some View {
    AsyncImage(url: url) { phase in
        switch phase {
        case .empty:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        case .success(let image):
            image
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipped()
        case .failure:
            Text("Failed to load image")
                 .foregroundColor(.red)
        @unknown default:
            EmptyView()
        }
    }
}

extension Color {
    init(hex: String) {
        // Removing "#" if it exists
        let hex = hex.replacingOccurrences(of: "#", with: "")
        
        // Parsing the hex string to a UIColor
        var hexInt: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&hexInt)
        
        let red = Double((hexInt >> 16) & 0xFF) / 255.0
        let green = Double((hexInt >> 8) & 0xFF) / 255.0
        let blue = Double(hexInt & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
