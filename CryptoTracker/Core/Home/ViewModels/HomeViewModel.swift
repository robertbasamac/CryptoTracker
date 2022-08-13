//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 13.08.2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portofolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portofolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
