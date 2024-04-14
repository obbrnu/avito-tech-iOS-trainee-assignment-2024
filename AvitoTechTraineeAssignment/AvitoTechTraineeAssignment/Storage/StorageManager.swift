//
//  StorageManager.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 14.04.2024.
//

import Foundation

final class StorageManager {
    
    fileprivate let userDefaults: UserDefaults
    static let shared = StorageManager()
    
    private init() { userDefaults = UserDefaults.standard }
}

extension StorageManager {
    
    func saveLastSearch(text: String) {
        var array = userDefaults.object(forKey: "lastSearches") as? [String] ?? [String]()
        
        guard !array.contains(text) else {
            array.removeAll(where: { $0 == text })
            array.append(text)
            array.insert(text, at: 0)
            return
        }
        
        if array.count >= 5 {
            array.removeLast()
        }
        array.insert(text, at: 0)
        
        userDefaults.set(array, forKey: "lastSearches")
    }
    
    func loadLastSearches() -> [String]{
        userDefaults.object(forKey: "lastSearches") as? [String] ?? [String]()
    }
}
