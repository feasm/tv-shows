//
//  ShowDetailViewModelTests.swift
//  tv-showsTests
//
//  Created by Felipe Melo on 06/07/22.
//

import XCTest
import Combine
@testable import tv_shows

class ShowDetailViewModelTests: XCTestCase {

    var viewModel: ShowDetailViewModel!
    var service: TVMazeServiceSpy!
    var localStorage: LocalStorageSpy!
    let showId = 1
    
    var cancelBag = [AnyCancellable]()

    override func setUpWithError() throws {
        localStorage = LocalStorageSpy()
        service = TVMazeServiceSpy()
        viewModel = ShowDetailViewModel(localStorage: localStorage, service: service, showId: showId)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetShowWithSuccess() {
        // Given
        let show = PreviewMocks.thorShow
        
        // When
        viewModel.getShow()
        
        // Then
        XCTAssertTrue(service.didCalledGetShow)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.name, show.name)
        XCTAssertEqual(viewModel.genres, show.genres)
        XCTAssertEqual(viewModel.schedule, show.formatSchedule())
        XCTAssertEqual(viewModel.rating, show.formatRating())
        XCTAssertEqual(viewModel.imageURL, show.image?.medium ?? "photo")
        XCTAssertEqual(viewModel.summary, show.summary.htmlToString())
        XCTAssertEqual(viewModel.type, show.type)
        XCTAssertEqual(viewModel.language, show.language)
        XCTAssertEqual(viewModel.status, show.status)
        XCTAssertEqual(viewModel.actors.count, 1)
        XCTAssertEqual(viewModel.lastSeason, 1)
        XCTAssertEqual(viewModel.episodes.count, 1)
    }
    
    func testAddFavorite() {
        // Given
        viewModel.isFavorite = false
        
        // When
        viewModel.getShow()
        viewModel.toggleFavorite()
        
        // Then
        XCTAssertTrue(viewModel.isFavorite)
        XCTAssertTrue(localStorage.didCalledAddFavorite)
        XCTAssertFalse(localStorage.didCalledRemoveFavorite)
    }
    
    func testRemoveFavorite() {
        // Given
        viewModel.isFavorite = true
        
        // When
        viewModel.getShow()
        viewModel.toggleFavorite()
        
        // Then
        XCTAssertFalse(viewModel.isFavorite)
        XCTAssertFalse(localStorage.didCalledAddFavorite)
        XCTAssertTrue(localStorage.didCalledRemoveFavorite)
    }

}
