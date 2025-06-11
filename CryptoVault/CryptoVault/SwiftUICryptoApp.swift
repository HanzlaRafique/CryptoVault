//
//  SwiftUICryptoApp.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 8/15/24.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView = true
   
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                NavigationView(content: {
                    HomeView()
                        .navigationBarHidden(true)
                })
                
                ZStack {
                    if showLaunchView {
                        LaunchScreenView(showLaunchView: $showLaunchView)
                    }
                }
                .zIndex(2)
            }
        }.environmentObject(vm)
    }
}
