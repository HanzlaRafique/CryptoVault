//
//  SearchView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/13/24.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var serachText: String
    
    var body: some View {
    
        HStack {
            Image(systemName: "magnifyingglass.circle")
                .foregroundColor(serachText.isEmpty ? .secondaryText : .accent)
                
            TextField("Please search here...", text: $serachText)
                .foregroundColor(.accent)
                .overlay(alignment: .trailing, content: {
                    
                    Image(systemName: "xmark.octagon")
                        .padding()
                        .foregroundColor(.accent)
                        .opacity(serachText.isEmpty ? 0 : 1)
                        .onTapGesture{
                            serachText = ""
                            UIApplication.shared.didEndEditing()
                        }
                })
                
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.thems.background)
                .shadow(color: .accent.opacity(0.5), radius: 10)
                .autocorrectionDisabled(true)
        )
        .padding()
        
    }
}

#Preview {
    SearchView(serachText: .constant(""))
}
