//
//  AppColorSettings.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 24.11.2024.
//

import SwiftUI

enum AppColorSettings {
    static let backgroundColor: Color = Color(uiColor: UIColor { (traits) -> UIColor in
        let isDarkMode = traits.userInterfaceStyle == .dark
        return isDarkMode ? UIColor(hexString: "#1A1B22") : UIColor(hexString: "#FFFFFF")
    })

    static let fontColor: Color = Color(uiColor: UIColor { (traits) -> UIColor in
        let isDarkMode = traits.userInterfaceStyle == .dark
        return isDarkMode ? UIColor(hexString: "#FFFFFF") : UIColor(hexString: "#1A1B22")
    })
    
    static let secondaryFontColor: Color = Color(uiColor: UIColor(hexString: "#AEAFB4"))
    
    static let backgroundButtonColor: Color = Color(uiColor: UIColor(hexString: "#3772E7"))
}
