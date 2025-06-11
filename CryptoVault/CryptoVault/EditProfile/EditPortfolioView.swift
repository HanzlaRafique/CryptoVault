//
//  EditProfileView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/18/24.
//

import SwiftUI

struct EditPortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var selectedCoins: CoinsModel? = nil
    @State var coinQuantity: String = ""
    @State var showCheckMark = false
    
    var body: some View {
      
        NavigationView(content: {
           
            ScrollView {
                
                SearchView(serachText: $vm.searchTxt)
                coinCardView
                
                if let selectedCoins = selectedCoins {
                    portfolioInputView
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Image(systemName: "xmark")
                    })
//                    XMarkButtonView()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    saveButtonView
                }
            })
            .onChange(of: vm.searchTxt) { oldValue, newValue in
                
                if newValue.isEmpty {
                    removeSelectedCoin()
                }
            }
        })
    }
}

#Preview {
    EditPortfolioView()
        .environmentObject(DeveloperView.instance.homeVM)
}


extension EditPortfolioView {
    
    var coinCardView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(vm.searchTxt.isEmpty ? vm.portfolioCoins : vm.coinsList) { coin in
                    CoinDetailView(coinDetail: coin)
                        .frame(width: 75)
                        .padding()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                updatePortfolio(coin: coin)
                            }
                        }
                        
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .stroke(selectedCoins?.id == coin.id ? Color.green : .clear , lineWidth: 1)
                        )
                }
            }.padding()
        }
    }
    
    var portfolioInputView: some View {
        VStack {
            HStack {
                Text("Current price of \(selectedCoins?.symbol?.uppercased() ?? "")")
                Spacer()
                Text("\(selectedCoins?.currentPrice?.asCurrencyWith6Decimals() ?? "0")")
            }
            Divider()

            HStack {
                
                Text("Amount holding:")
            
                Spacer()
                
                TextField("Ex: 1.4", text: $coinQuantity)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            
            Divider()
            
            HStack {
                
                Text("Calculated price:")
            
                Spacer()
                
                Text(calculateValue().asCurrencyWith6Decimals())
            }
        }
        .animation(.none)
        .padding()

    }
    
    var saveButtonView: some View {
        
        HStack {
            Image(systemName: "checkmark.circle")
                .opacity(showCheckMark ? 1.0 : 0.0)
                .tint(.green)
            
            Button(action: {
                
                saveButtonTapped()
                
            }, label: {
                    Text("SAVE")
            })
            .opacity((selectedCoins != nil && (selectedCoins?.currentPrice ?? 0.0) != Double(coinQuantity)) ? 1 : 0 )
        }
    }
    
    func calculateValue() -> Double {
        return Double(selectedCoins?.currentPrice ?? 0.0) * (Double(coinQuantity) ?? 0)
    }
    
    func saveButtonTapped() {
        
        guard let coin = selectedCoins,
              let amount = Double(coinQuantity)
        
        else {
            return
        }
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeInOut) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut) {
                showCheckMark = false
            }
        }
    }
    
    func updatePortfolio(coin: CoinsModel) {
        
        selectedCoins = coin
        
        guard let coin = vm.portfolioCoins.first(where: {$0.id == coin.id}), let amount = coin.currentHoldings else {
            coinQuantity = ""
            return
        }
        coinQuantity = "\(amount)"
    }
    
    func removeSelectedCoin() {
        selectedCoins = nil
        vm.searchTxt = ""
    }
    
}
