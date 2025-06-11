//
//  CoinDetailModel.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/25/24.

import Foundation

// MARK: - Welcome
struct CoinDescriptionModel: Codable {
    let id, symbol, name, webSlug: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: CoinDescription?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, webSlug, description, links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
    
    var readableDescription: String? {
        return description?.en?.removingHtmlOccurance
    }
}

struct CoinDescription: Codable {
    let en: String?
}

struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}
