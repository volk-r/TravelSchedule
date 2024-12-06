//
//  StoryModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import Foundation

struct StoryData {
    let backgroundColor: StoryColor
    let title: String
    let description: String
    
    static let story1 = StoryData(
        backgroundColor: .firstPage,
        title: "🎉 ⭐️ ❤️",
        description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 "
    )

    static let story2 = StoryData(
        backgroundColor: .secondPage,
        title: "😍 🌸 🥬",
        description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 "
    )

    static let story3 = StoryData(
        backgroundColor: .thirdPage,
        title: "🧀 🥑 🥚",
        description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 "
    )
}
