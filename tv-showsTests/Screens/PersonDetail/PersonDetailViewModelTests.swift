//
//  PersonDetailViewModelTests.swift
//  tv-showsTests
//
//  Created by Felipe Melo on 06/07/22.
//

import XCTest
import Combine
@testable import tv_shows

class PersonDetailViewModelTests: XCTestCase {

    var viewModel: PersonDetailViewModel!
    var service: TVMazeServiceSpy!
    var localStorage: LocalStorageSpy!
    
    var cancelBag = [AnyCancellable]()

    override func setUpWithError() throws {
        service = TVMazeServiceSpy()
        viewModel = PersonDetailViewModel(service: service, personModel: PreviewMocks.stephenKing)
    }

    func testGetPersonDetailWithSuccess() {
        // Given
        
        // When
        viewModel.getPersonDetail()
        
        // Then
        XCTAssertTrue(service.didCalledGetPersonShows)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.personShowsViewModel.count, 1)
    }

}
