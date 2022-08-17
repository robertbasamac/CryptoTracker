//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 14.08.2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private let coin: CoinModel
    private var imageSubscription: AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
        
//            5. decode the data
            .tryMap({ (data) -> UIImage? in
                return UIImage(data:  data)
            })
        
//            6. put the item into our app using sink
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
