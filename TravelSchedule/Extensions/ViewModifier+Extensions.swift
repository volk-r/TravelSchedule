//
//  ViewModifier+Extensions.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 02.12.2024.
//

import SwiftUI

extension ViewModifier where Self == DarkModeViewModifier {
    static var colorScheme: DarkModeViewModifier { DarkModeViewModifier() }
}

extension ViewModifier where Self == NavigationViewBugFixViewModifier {
    static var iOS18PlusBugFix: NavigationViewBugFixViewModifier { NavigationViewBugFixViewModifier() }
}
