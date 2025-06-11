//
//  CoinImageView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/10/24.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: CoinsModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coinModel: coin))
    }
    
    var body: some View {
        
        ZStack {
            
            if let img = viewModel.coinImage {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                
            } else if viewModel.isLoading {
                ProgressView()
                
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.secondaryText)
            }
            
        }
        
        
    }
}

#Preview {
    CoinImageView(coin: DeveloperView.instance.coin)
}
