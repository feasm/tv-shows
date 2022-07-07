//
//  LocalStorageSpy.swift
//  tv-showsTests
//
//  Created by Felipe Melo on 06/07/22.
//

import Foundation
import Combine
@testable import tv_shows

final class LocalStorageSpy: LocalStorage {
    var onUpdate = PassthroughSubject<[ShowModel], Never>()
    var didCalledAddFavorite = false
    var didCalledRemoveFavorite = false
    var didCalledCheckIsFavorite = false
    var didCalledGetFavorite = false
    
    func addFavorite(show: ShowModel) {
        didCalledAddFavorite = true
    }
    
    func removeFavorite(show: ShowModel) {
        didCalledRemoveFavorite = true
    }
    
    func checkIsFavorite(id: Int) -> Bool {
        didCalledCheckIsFavorite = true
        return true
    }
    
    func getFavorites() -> [ShowModel] {
        didCalledGetFavorite = true
        return [
            PreviewMocks.thorShow,
            PreviewMocks.thorShow
        ]
    }
    
    
}
