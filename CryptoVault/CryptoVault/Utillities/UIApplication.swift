//
//  UIApplication.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/16/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func didEndEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
