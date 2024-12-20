//
//  NavigationViewBugFixViewModifier.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 19.12.2024.
//

import SwiftUI

struct NavigationViewBugFixViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        // iOS 18 bug workaround, broken NavigationStack behavior on 18 iOS and above
        // for more details see thread https://forums.developer.apple.com/forums/thread/764306
        NavigationView {
            content
        }
        .navigationBarBackButtonHidden()
    }
}
