//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 30.08.2022.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    
    private var coinDetailSubscription: AnyCancellable?
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        
        Task {
            do {
                try await getCoinDetailsWithAsync()
            } catch {
                throw error
            }
        }
        
//        getCoinDetails()
    }
    
    private func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkingManager.downloadWithCombine(url: url)
//            5. decode the data
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
//            6. put the item into our app using sink
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
    
    private func getCoinDetailsWithAsync() async throws {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }

        do {
            let data = try await NetworkingManager.downloadWithAsync(url: url)
            let coinsDetails = try JSONDecoder().decode(CoinDetailModel.self, from: data)
            
            await MainActor.run(body: {
                coinDetails = coinsDetails
            })
        } catch {
            throw error
        }
    }
}
