//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 24.08.2022.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    
    private var marketDataSubscription: AnyCancellable?
    
    init() {
        Task {
            do {
                try await getDataWithAsync()
            } catch {
                throw error
            }
        }
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.downloadWithCombine(url: url)
//            5. decode the data
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
//            6. put the item into our app using sink
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
    
    func getDataWithAsync() async throws {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }

        do {
            let data = try await NetworkingManager.downloadWithAsync(url: url)
            guard let returnedMarketData = try? JSONDecoder().decode(GlobalData.self, from: data) else { return }
            
            await MainActor.run(body: {
                marketData = returnedMarketData.data
            })
        } catch {
            throw error
        }
    }
}
