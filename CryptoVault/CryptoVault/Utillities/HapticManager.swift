//
//  HapticManager.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/24/24.
//

import Foundation
import SwiftUI


class HapticManager {
    
    static private let genrator = UINotificationFeedbackGenerator()
    
    static func notification(notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        genrator.notificationOccurred(notificationType)
    }
    
}
