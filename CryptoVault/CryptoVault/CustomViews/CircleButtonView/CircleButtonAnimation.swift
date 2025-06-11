//
//  CircleButtonAnimation.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 8/15/24.
//

import SwiftUI

struct CircleButtonAnimation: View {
    
    @Binding var isAnimate: Bool
    
    var body: some View {
        
        Circle()
            .stroke(lineWidth: 5)
            .scale(isAnimate ? 1 : 0)
            .opacity(isAnimate ? 0 : 1)
            .animation(isAnimate ? Animation.easeInOut(duration: 1.0) : .none)
            .onAppear {
                isAnimate.toggle()
            }
    }
}

#Preview {
    CircleButtonAnimation(isAnimate: .constant(false))
}
