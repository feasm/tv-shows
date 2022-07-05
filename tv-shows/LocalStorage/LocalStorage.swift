//
//  LocalStorage.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import Foundation

protocol LocalStorage {
    func addFavorite(show: ShowModel)
    func removeFavorite(show: ShowModel)
    func checkIsFavorite(id: Int) -> Bool
    func getFavorites() -> [ShowModel]
}

final class LocalStorageImpl: LocalStorage {
    
    static let favoriteKey = "favoriteList"
    
    let userDefaults: UserDefaults
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func addFavorite(show: ShowModel) {
        var favoriteList = getFavorites()
        
        if !favoriteList.contains(where: { $0.id == show.id }) {
            favoriteList.append(show)
        }
        
        if let encodedData = try? encoder.encode(favoriteList) {
            userDefaults.set(encodedData, forKey: LocalStorageImpl.favoriteKey)
        }
    }
    
    func removeFavorite(show: ShowModel) {
        var favoriteList = getFavorites()
        
        favoriteList.removeAll(where: { $0.id == show.id })
        
        if let encodedData = try? encoder.encode(favoriteList) {
            userDefaults.set(encodedData, forKey: LocalStorageImpl.favoriteKey)
        }
    }
    
    func checkIsFavorite(id: Int) -> Bool {
        let favoriteList = getFavorites()
        
        return favoriteList.contains(where: { $0.id == id })
    }
    
    func getFavorites() -> [ShowModel] {
        if let favoriteList  = userDefaults.data(forKey: LocalStorageImpl.favoriteKey) {
            let showList = try? decoder.decode([ShowModel].self, from: favoriteList)
            
            return showList?.sorted(by: { $0.name < $1.name }) ?? []
        }
        
        return []
    }
    
}
