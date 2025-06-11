//
//  CoinService.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 8/30/24.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinsModel] = []
    var coinsCancel: AnyCancellable?
    
    init() {
        getCoinsData()
    }
    
    func getCoinsData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
        coinsCancel = NetworkManager.download(url: url)
            .decode(type: [CoinsModel].self, decoder: JSONDecoder())
            
            .sink { (completion) in NetworkManager.handlerCompletion(completion: completion) } receiveValue: { [weak self] listOfCoins in
                self?.allCoins = listOfCoins
                self?.coinsCancel?.cancel()
            }
    }
}

