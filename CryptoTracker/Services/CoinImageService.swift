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
    
    private let fileManager = LocalFileManager.shared
    private let imageName: String
    private let folderName = "coin_images"
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            Task {
                do {
                    try await downloadCoinImageWithAsync()
                } catch {
                    throw error
                }
            }
            
//            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.downloadWithCombine(url: url)
        
//            5. decode the data
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
//            6. put the item into our app using sink
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let downloadedImage = returnedImage
                else { return }
                
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
    private func downloadCoinImageWithAsync() async throws {
        guard let url = URL(string: coin.image) else { return }

        do {
            let data = try await NetworkingManager.downloadWithAsync(url: url)
            guard let returnedImage = UIImage(data: data) else { return }
            
            await MainActor.run(body: {
                image = returnedImage
                fileManager.saveImage(image: returnedImage, imageName: self.imageName, folderName: self.folderName)
            })
        } catch {
            throw error
        }
    }
}
