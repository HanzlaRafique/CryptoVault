//
//  StringExt.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/26/24.
//

import Foundation

extension String {
    
    var removingHtmlOccurance: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
