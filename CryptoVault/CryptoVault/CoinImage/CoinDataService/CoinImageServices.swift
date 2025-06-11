//
//  CoinImageServices.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/11/24.
//

import Foundation
import SwiftUI
import Combine



class CoinImageServices {
    
    @Published var coinImage: UIImage?
    
    var imageCancele: AnyCancellable?
    var coin: CoinsModel
    private let fileManager = LocalFileManager.instance
    private var imageName: String
    private var folderName = "coin_images"
    
    init(coin: CoinsModel) {
        self.coin = coin
        self.imageName = coin.name ?? ""
        getCoinImage()
    }
    
    func getCoinImage() {
        
        if let image = fileManager.getImage(imageName: imageName, folderName: folderName) {
            coinImage = image
            print("Downloaded....")
        } else {
            downloadCoinImage()
            print("Downloading....")
        }
    }
    
    func downloadCoinImage() {
        
        guard let url = URL(string: coin.image ?? "") else {
            return
        }
        
        imageCancele = NetworkManager.download(url: url)
            .tryMap { (data) -> UIImage? in
                return UIImage(data: data)
            }
            .sink { (completion) in NetworkManager.handlerCompletion(completion: completion) } receiveValue: { [weak self] returnImage in
                
                guard let self = self, let returnImage = returnImage else {return}
                
                self.coinImage = returnImage
                self.imageCancele?.cancel()
                self.fileManager.saveImage(image: returnImage, imageName: imageName, folderName: folderName)
            }
    }
}
