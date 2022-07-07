//
//  HomeViewModelTests.swift
//  tv-showsTests
//
//  Created by Felipe Melo on 06/07/22.
//

import XCTest
import Combine
@testable import tv_shows

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var service: TVMazeServiceSpy!
    var localStorage: LocalStorageSpy!
    
    var cancelBag = [AnyCancellable]()

    override func setUpWithError() throws {
        localStorage = LocalStorageSpy()
        service = TVMazeServiceSpy()
        viewModel = HomeViewModel(service: service, localStorage: localStorage)
    }

    func  testFetchShowWithSuccess() {
        // Given
        
        // When
        viewModel.fetchShows()
        
        // Then
        XCTAssertTrue(service.didCalledFetchShows)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.movies.count, 1)
        
        XCTAssertEqual(viewModel.sectionViewModels.count, 1)
        XCTAssertEqual(viewModel.favoriteShowViewModels.count, 2)
        XCTAssertEqual(viewModel.filteredShowViewModels.count, 0)
        
        XCTAssertTrue(localStorage.didCalledGetFavorite)
    }
    
    func testSearchShowsWithSuccess() {
        // Given
        viewModel.searchText = "Alladin"
        
        // When
        viewModel.searchShows()
        
        // Then
        XCTAssertTrue(service.didCalledSearchShow)
        XCTAssertEqual(viewModel.searchText, service.searchText)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.filteredShowViewModels.count, 1)
    }
    
    func testClearSearch() {
        // Given
        viewModel.filteredShowViewModels = [ShowViewModel(show: PreviewMocks.thorShow)]
        
        // When
        viewModel.clearSearch()
        
        // Then
        XCTAssertEqual(viewModel.filteredShowViewModels.count, 0)
    }
    
    func testUpdateFavorites() {
        // Given
        
        // When
        viewModel.updateFavorites()
        
        // Then
        XCTAssertTrue(localStorage.didCalledGetFavorite)
        XCTAssertEqual(viewModel.favoriteShowViewModels.count, 2)
        XCTAssertEqual(viewModel.favoritesSectionViewModel.showViewModels.count, 2)
    }

}
