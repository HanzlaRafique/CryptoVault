//
//  CoinDetailView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/19/24.
//

import SwiftUI

struct CoinDetailView: View {
    
    @State var coinDetail: CoinsModel
    
    var body: some View {
        
        
        VStack {
            
           CoinImageView(coin: coinDetail)
                .frame(width: 50, height: 50)
            
            Text(coinDetail.symbol?.uppercased() ?? "")
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundStyle(.accent)
            
            Text(coinDetail.name ?? "")
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundStyle(.secondary)
        }
        .frame(width: 100)
        
        
    }
}

#Preview {
    CoinDetailView(coinDetail: DeveloperView.instance.coin)
}
