//
//  CoinDetailService.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/25/24.
//

import Foundation
import Combine


class CoinDetailService {
    
    var coin: CoinsModel
    var cancellable: AnyCancellable?
    @Published var detailCoin: CoinDescriptionModel?
    
    init(coinDetail: CoinsModel) {
        self.coin = coinDetail
        getCoinDetail()
    }
    
    func getCoinDetail() {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id ?? "")?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        
        guard let url = url else {
            return
        }
        
        cancellable = NetworkManager.download(url: url)
            .decode(type: CoinDescriptionModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (completion) in NetworkManager.handlerCompletion(completion: completion)
            }, receiveValue: { [weak self] (data) in
                self?.detailCoin = data
                self?.cancellable?.cancel()
            })
    }
    
}
