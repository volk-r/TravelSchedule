//
//  NavigationViewBugFixViewModifier.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 19.12.2024.
//

import SwiftUI

struct NavigationViewBugFixViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        /// iOS 18 bug fix, https://forums.developer.apple.com/forums/thread/764306
        NavigationView {
            content
        }
        .navigationBarBackButtonHidden()
    }
}
