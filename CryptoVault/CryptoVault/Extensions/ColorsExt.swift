//
//  ColorsExt.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 8/15/24.
//

import Foundation
import SwiftUI


extension Color {
    
    static let thems = ColorThems()
    static let launchTheme = LaunchTheme()
}


struct ColorThems {
    
    let accent = Color("AccentColor")
    let red = Color("RedColor")
    let green = Color("GreenColor")
    let secondaryTxtColor = Color("SecondaryTextColor")
    let background = Color("BackgourndColor")
}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
