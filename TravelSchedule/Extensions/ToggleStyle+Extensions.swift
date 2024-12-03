//
//  ToggleStyle+Extensions.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 29.11.2024.
//

import SwiftUI

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checkmark: CheckboxToggleStyle { CheckboxToggleStyle() }
}

extension ToggleStyle where Self == RadioButtonToggleStyle {
    static var radioButton: RadioButtonToggleStyle { RadioButtonToggleStyle() }
}
