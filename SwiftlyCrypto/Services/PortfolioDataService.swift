//
//  PortfolioDataService.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 26/09/2025.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntity: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error on loading Core Data! \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    //Mark: - PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntity.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                deelete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    // Mark: - PRIVATE
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities: \(error.localizedDescription)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amouont = amount
        
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amouont = amount
        applyChanges()
    }
    
    private func deelete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
