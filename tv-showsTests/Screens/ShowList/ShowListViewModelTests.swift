//
//  ShowListViewModelTests.swift
//  tv-showsTests
//
//  Created by Felipe Melo on 06/07/22.
//

import XCTest
import Combine
@testable import tv_shows

class ShowListViewModelTests: XCTestCase {

    var viewModel: FavoriteListViewModel!
    var service: TVMazeServiceSpy!
    var localStorage: LocalStorageSpy!
    
    let title = "Favorites"
    var shows = [ShowViewModel]()
    
    var cancelBag = [AnyCancellable]()

    override func setUpWithError() throws {
        shows = [ShowViewModel(show: PreviewMocks.thorShow)]
        localStorage = LocalStorageSpy()
        service = TVMazeServiceSpy()
        viewModel = FavoriteListViewModel(title: title, showViewModels: shows, localStorage: localStorage)
    }

    func testFilterShowsWithSuccess() {
        // Given
        viewModel.searchText = "Thor"
        
        // When
        
        // Then
        XCTAssertEqual(viewModel.filteredShowViewModels.count, 1)
    }
    
    func testFilterShowsWithError() {
        // Given
        viewModel.searchText = "Stephen"
        
        // When
        
        // Then
        XCTAssertEqual(viewModel.filteredShowViewModels.count, 0)
    }
    
    func testFilterShowsWithEmpty() {
        // Given
        viewModel.searchText = ""
        
        // When
        
        // Then
        XCTAssertEqual(viewModel.filteredShowViewModels.count, 1)
    }
    
    func testOnUpdateFavorites() {
        // Given
        viewModel.searchText = ""
        
        // When
        localStorage.onUpdate.send([PreviewMocks.thorShow])
        
        // Then
        XCTAssertEqual(viewModel.filteredShowViewModels.count, 1)
    }

}
