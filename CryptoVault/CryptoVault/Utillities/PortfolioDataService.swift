//
//  PortfolioDataService.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/20/24.
//

import Foundation
import CoreData


class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let entityName = "PortfolioEntity"
    private let containerName = "PortfolioContainer"
    
    @Published var savedEntries: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            
            if let error = error {
                print("Error while loading container ... \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    func updatePortfolio(coin: CoinsModel, amount: Double) {
        
        if let entry = savedEntries.first(where: {$0.id == coin.id}) {
            
            amount > 0 ? update(entity: entry, amount: amount) : deleteEntry(entity: entry)
            
        } else {
            addEntry(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio() {
        
        let entity = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntries = try container.viewContext.fetch(entity)
            
        } catch let error {
            print("Error while getPortfolio ... \(error.localizedDescription)")
        }
    }
    
    private func addEntry(coin: CoinsModel, amount: Double) {
        
        let entity = PortfolioEntity(context: container.viewContext)
        
        entity.id = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func deleteEntry(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func saveEntry() {
        
        do {
            try container.viewContext.save()
            
        } catch let error {
            print("Error while save enrty ... \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        saveEntry()
        getPortfolio()
    }
    
}
