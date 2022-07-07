//
//  TVMazeServiceTests.swift
//  tv-showsTests
//
//  Created by Felipe Melo on 06/07/22.
//

import XCTest
import Combine
@testable import tv_shows

class TVMazeServiceTests: XCTestCase {
    
    var service: TVMazeServiceImpl!
    
    var cancelBag = [AnyCancellable]()

    override func setUpWithError() throws {
        service = TVMazeServiceImpl()
    }
    
    private func testRequest<T>(publisher: AnyPublisher<T, NetworkError>) {
        // Given
        var expectation = expectation(description: "expectation")
        var didReceivedValue = false
        
        // When
        publisher
            .sink { _ in } receiveValue: { _ in
                didReceivedValue = true
                expectation.fulfill()
            }
            .store(in: &cancelBag)

        waitForExpectations(timeout: 1000)
        
        // Then
        XCTAssertTrue(didReceivedValue)
    }

    func testFetchShows() {
        testRequest(publisher: service.fetchShows())
    }
    
    func testFetchPeople() {
        testRequest(publisher: service.fetchPeople())
    }
    
    func testSearchShow() {
        testRequest(publisher: service.searchShow(searchText: "Cult"))
    }
    
    func testGetShow() {
        testRequest(publisher: service.getShow(id: 1))
    }
    
    func testGetPersonShows() {
        testRequest(publisher: service.getPersonShows(id: 100))
    }

}
