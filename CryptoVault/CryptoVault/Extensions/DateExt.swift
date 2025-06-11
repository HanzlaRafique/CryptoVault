//
//  DateExt.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/26/24.
//

import Foundation


extension Date {
    
    init(coinGeckoString: String) {
        
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formater.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
        
    }
    
    private var shortDate: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .short
        return formater
    }
    
    func asShortDateString() -> String {
        return shortDate.string(from: self)
    }
    
}
