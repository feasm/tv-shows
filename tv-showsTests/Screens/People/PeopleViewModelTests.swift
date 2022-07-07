//
//  PeopleViewModelTests.swift
//  tv-showsTests
//
//  Created by Felipe Melo on 06/07/22.
//

import XCTest
import Combine
@testable import tv_shows

class PeopleViewModelTests: XCTestCase {

    var viewModel: PeopleViewModel!
    var service: TVMazeServiceSpy!
    let showId = 1
    
    var cancelBag = [AnyCancellable]()

    override func setUpWithError() throws {
        service = TVMazeServiceSpy()
        viewModel = PeopleViewModel(service: service)
    }

    func testFetchPeopleWithSuccess() {
        // Given
        
        // When
        viewModel.fetchPeople()
        
        // Then
        XCTAssertTrue(service.didCalledFetchPeople)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.peopleViewModels.count, 1)
    }
    
    func testObserveSearchText() {
        // Given
        viewModel.searchText = ""
        
        // When
        viewModel.fetchPeople()
        viewModel.searchText = "Stephen"
        
        // Then
        XCTAssertEqual(viewModel.peopleViewModels.count, 1)
    }

    func testObserveSearchTextEmpty() {
        // Given
        viewModel.searchText = ""
        
        // When
        viewModel.fetchPeople()
        viewModel.searchText = "Thor"
        
        // Then
        XCTAssertEqual(viewModel.peopleViewModels.count, 0)
    }
}
