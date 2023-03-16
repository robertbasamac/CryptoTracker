//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 14.08.2022.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    
    private var coinSubscription: AnyCancellable?
    
    init() {
        Task {
            do {
                try await getConinsWithAsync()
            } catch {
                throw error
            }
        }
        
//        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.downloadWithCombine(url: url)
//            5. decode the data
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
//            6. put the item into our app using sink
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
    
    func getConinsWithAsync() async throws {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        do {
            let data = try await NetworkingManager.downloadWithAsync(url: url)
            let returnedCoins = try JSONDecoder().decode([CoinModel].self, from: data)
            
            await MainActor.run(body: {
                allCoins = returnedCoins
            })
        } catch {
            throw error
        }
    }
}
