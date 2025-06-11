//
//  CoinImageViewModel.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/10/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    
    @Published var coinImage: UIImage?
    @Published var isLoading: Bool = false
    var coinImageViewCancel = Set<AnyCancellable>()
    
    private var dataService: CoinImageServices
    private var coin: CoinsModel
    
    init(coinModel: CoinsModel) {
        self.coin = coinModel
        self.dataService = CoinImageServices(coin: coin)
        addSubscription()
    }
    
    private func addSubscription() {
        dataService.$coinImage
            .sink { [weak self] image in
                self?.coinImage = image
            }
            .store(in: &coinImageViewCancel)
    }
    
}
