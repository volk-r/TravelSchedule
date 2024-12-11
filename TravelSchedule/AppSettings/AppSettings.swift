//
//  AppSettings.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 02.12.2024.
//

import SwiftUI

final class AppSettings: ObservableObject {
    
    // MARK: - Properties
    
    @AppStorage("darkMode") var isDarkModeEnabled: Bool = false
    
    @AppStorage("storiesShowed") private var storiesShowed: Data = Data()
    
    // MARK: - getAppVersion
    
    func getAppVersion() -> String {
        guard
            let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? AnyObject,
            let appVersion = nsObject as? String
        else {
            return ""
        }
        return appVersion
    }
    
    // MARK: - markAsShowed
    
    func markAsShowed(story: StoryData) {
        var storiesIdList: Set<String> = loadStoriesItems()
        storiesIdList.insert(story.id.description)
        saveStoriesItems(storiesIdList)
    }
    
    // MARK: - isStoryShowed
    
    func isStoryShowed(story: StoryData) -> Bool {
        let storiesIdList: Set<String> = loadStoriesItems()
        return storiesIdList.contains(story.id.description)
    }
    
    // MARK: - loadStoriesItems
    
    private func loadStoriesItems() -> Set<String> {
        guard
            let decodedArray = try? JSONDecoder().decode([String].self, from: storiesShowed)
        else {
            return []
        }
        return Set(decodedArray)
    }
    
    // MARK: - saveStoriesItems
    
    private func saveStoriesItems(_ storiesItem: Set<String>) {
        let itemsArray = Array(storiesItem)
        guard let encodedData = try? JSONEncoder().encode(itemsArray) else { return }
        storiesShowed = encodedData
    }
}
