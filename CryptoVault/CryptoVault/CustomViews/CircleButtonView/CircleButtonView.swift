//
//  CircleButtonView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 8/15/24.
//

import SwiftUI

struct CircleButtonView: View {
    
    let imageName: String
    
    var body: some View {
        
        ZStack {
            
            Image(systemName: imageName)
                .font(.headline)
                .foregroundStyle(Color.thems.accent)
                .frame(width: 50, height: 50)
                .background {
                    Circle()
                        .foregroundStyle(Color.thems.background)
                }
                .shadow(
                    color: .thems.accent.opacity(1),
                    radius: 15, x: 0, y: 0)
                .padding()
                
            
        }
        
    }
}

#Preview {
    
    Group {
        CircleButtonView(imageName: "info")
        
        CircleButtonView(imageName: "plus")
    }
}
