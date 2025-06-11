//
//  ContentView.swift
//  SwiftUICrypto
//
//  Created by TGI-2 on 8/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color.thems.red
                .ignoresSafeArea()
            Text("Hello, world!")
                .background(Color.thems.green)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
