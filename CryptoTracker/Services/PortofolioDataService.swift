//
//  PortofolioDataService.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 26.08.2022.
//

import Foundation
import CoreData

class PortofolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortofolioContainer"
    private let entityName: String = "PortofolioEntity"
    
    @Published var savedEntities: [PortofolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading CoreData, \(error)")
            }
            
            self.getPortofolio()
        }
    }
    
    //MARK: - Public
    
    func updatePortofolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    //MARK: - Private
    private func getPortofolio() {
        let request = NSFetchRequest<PortofolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portofolio Entities, \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortofolioEntity(context: container.viewContext)
        
        entity.coinID = coin.id
        entity.amount = amount
        
        applyChanges()
    }
    
    private func update(entity: PortofolioEntity, amount: Double) {
        entity.amount = amount
        
        applyChanges()
    }
    
    private func remove(entity: PortofolioEntity) {
        container.viewContext.delete(entity)
        
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to CoreData, \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortofolio()
    }
}
