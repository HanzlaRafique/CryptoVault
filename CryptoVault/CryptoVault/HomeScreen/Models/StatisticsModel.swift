//
//  StatisticsModel.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/16/24.
//

import Foundation

struct StatisticsModel: Identifiable {
    var id = UUID().uuidString
    var title: String?
    var value: String?
    var percentage: Double?
    
    init(id: String = UUID().uuidString, title: String?, value: String?, percentage: Double? = nil) {
        self.id = id
        self.title = title
        self.value = value
        self.percentage = percentage
    }
}


// MARK: - Welcome
struct MarketDataModel: Codable {
    let data: MarketData?
}

// MARK: - DataClass
struct MarketData: Codable {
    var activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int?
    var markets: Int?
    var totalMarketCap, totalVolume, marketCapPercentage: [String: Double]?
    var marketCapChangePercentage24HUsd: Double?
    var updatedAt: Int?

    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    
    var marketCap: String {
        
        if let item = totalMarketCap?.first(where: {$0.key.lowercased() == "usa"}) {
            return "\(item.value)"
        }
        
        return ""
    }
    
    var volume: String {
        if let item = totalVolume?.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var capPercentage: String {
        
        if let item = marketCapPercentage?.first(where: {$0.key.lowercased() == "usa"}) {
            return "\(item.value)"
        }
        
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage?.first(where: { $0.key == "btc" }) {
            return item.value.asNumberString()
        }
        return ""
    }
}

