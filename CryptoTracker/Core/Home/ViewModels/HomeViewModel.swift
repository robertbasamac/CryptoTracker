//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 13.08.2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portofolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService: CoinDataService = CoinDataService()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // this is being removed because the other subscriber already updates allCoins
//        dataService.$allCoins
//            .sink { [weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
         
        return coins.filter { (coin) -> Bool in
            return (coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText))
        }
    }
}
