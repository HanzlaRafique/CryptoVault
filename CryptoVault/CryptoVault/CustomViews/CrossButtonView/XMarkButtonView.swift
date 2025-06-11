//
//  XMarkButtonView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/18/24.
//

import SwiftUI

struct XMarkButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Image(systemName: "xmark")
            })

//            Text("TODO: Implement logic")
        }
    }
}

#Preview {
    XMarkButtonView()
}
