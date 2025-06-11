//
//  CoinRowView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 8/16/24.
//

import SwiftUI

struct CoinRowView: View {
    let coin : CoinsModel
    var showColum: Bool
    
    var body: some View {
        
        HStack {
            
            leftColum
            Spacer()
            
            if showColum {
                centerColum
            }
            
            Spacer()
            rightColum
            
        }
        .padding(.horizontal)
        .background(.black.opacity(0.001))
    }
} 

#Preview {
    CoinRowView(coin: DeveloperView.instance.coin, showColum: true)
        .previewLayout(.sizeThatFits)
}


extension CoinRowView {
    
    private var leftColum: some View {
        
        HStack {
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            
            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
                .bold()
        }
    }
    
    private var centerColum: some View {
        VStack (alignment: .trailing){
            
            let currentHoldings = coin.currentHoldings ?? 0
            let currentPrice = coin.currentPrice ?? 0
            let currentHoldingPrice =  currentHoldings * currentPrice
            
            Text("\(currentHoldingPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundStyle(Color.thems.accent)
            
            Text("\(currentHoldings.asNumberString())")
        }
    }
    
    private var rightColum: some View {
        VStack (alignment: .trailing){
            Text("\(coin.currentPrice?.asCurrencyWith6Decimals() ?? "0")")
                .bold()
                .foregroundStyle(Color.thems.accent)
            
            Text("\(coin.priceChangePercentage24H?.asNumberString() ?? "0") %")
                .bold()
                .foregroundStyle(
                
                    (Int(coin.priceChangePercentage24H?.asNumberString() ?? "0") ?? 0) > 0 ? Color.thems.green : Color.thems.red
                
                )
            
        }
    }
    
}
