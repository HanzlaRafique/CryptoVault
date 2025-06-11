//
//  LaunchScreenView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/27/24.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var loadTextAray: [String] = "Load your portfolio...".map{String($0)}
    @State private var showLoading = false
    @Binding var showLaunchView: Bool
    @State var counter = 0
    @State var loopCounter = 0
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        ZStack {
            Color.launchTheme.background
                .ignoresSafeArea()
            
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                
                HStack(spacing: 0) {
                    
                    if showLoading {
                        ForEach (loadTextAray.indices) { index in
                            Text(loadTextAray[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(.launchAccent)
                                .offset(y: counter == index ? -50 : 0)
                        }
                        .transition(AnyTransition.scale.animation(.easeIn))
                    }
                    
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoading.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring) {
                let loading = loadTextAray.count - 1
                
                if loading == counter {
                    counter = 0
                    loopCounter += 1
                    
                    if loopCounter >= 2 {
                        showLaunchView = false
                    }
                    
                } else {
                    
                    counter += 1
                }
                
            }
            
        })
    }
}

#Preview {
    LaunchScreenView(showLaunchView: .constant(true))
}
