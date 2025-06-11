//
//  SettingView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/27/24.
//

import SwiftUI

struct SettingView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://www.nicksarno.com")!
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView() {
            
           
            List {
                
                swiftfulThinkingSection
                    .listRowBackground(Color.thems.background.opacity(0.5))
                coinGeckoView
                    .listRowBackground(Color.thems.background.opacity(0.5))
                developerSection
                    .listRowBackground(Color.thems.background.opacity(0.5))
                applicationSection
                    .listRowBackground(Color.thems.background.opacity(0.5))
                
            }
            .navigationTitle("Setting")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            })
        }
        
    }
}

#Preview {
    SettingView()
}


extension SettingView {
    
    var swiftfulThinkingSection: some View {
        
        Section {
            VStack(alignment: .leading) {
                
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(.buttonBorder)
                
                Text("This app is a learning project for SwiftUI. It uses MVVM Architecture, Combine, and CoreData!")
            }
            
            HStack {
                Link("You can search for more videos on YouTube", destination: youtubeURL)
                    .foregroundStyle(Color.blue)
                    .bold()
                Image(systemName: "video.fill")
                    .foregroundStyle(Color.red)
            }
            
        } header: {
            Text("Think differently about SwiftUI")
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        
    }
    
    var coinGeckoView: some View {
    
        Section {
            VStack(alignment: .leading) {
                
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(.buttonBorder)
                
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
            }
            
            HStack {
                Link("Visit CoinGecko", destination: coingeckoURL)
                    .foregroundStyle(Color.blue)
                    .bold()
                
                Image(systemName: "bitcoinsign.circle.fill")
                    .foregroundStyle(Color.yellow)
            }
            
        } header: {
            Text("Coin Gecko")
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Nick Sarno. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.thems.accent)
            }
            .padding(.vertical)
            Link("Visit Website 🤙", destination: personalURL)
                .foregroundStyle(Color.blue)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            
            Link("Terms of Service", destination: defaultURL)
                .foregroundStyle(Color.blue)
            Link("Privacy Policy", destination: defaultURL)
                .foregroundStyle(Color.blue)
            Link("Company Website", destination: defaultURL)
                .foregroundStyle(Color.blue)
            Link("Learn More", destination: defaultURL)
                .foregroundStyle(Color.blue)
            
        }
    }
    
}
