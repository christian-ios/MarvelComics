//
//  ComicsListViewModelTests.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//
import Foundation
import XCTest
@testable import MarvelComics

class ComicsListViewModelTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() async throws {
        mockNetworkManager = MockNetworkManager()
    }
    override func tearDown() {
        mockNetworkManager = nil
    }
    
    @MainActor
    func testLoadComicsSuccess() async throws {
        // Setup
        let comicsService = ComicsService(networkManager: mockNetworkManager)
        let viewModel = ComicsListViewModel(comicsService: comicsService)
        
        // Action
        await viewModel.loadComics()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.comics.count, 2)
    }
    
    @MainActor
    func testLoadActualComicsSuccess() async throws {
        // Setup
        let viewModel = ComicsListViewModel()
        
        // Action
        await viewModel.loadComics()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssert(!viewModel.comics.isEmpty)
    }
    
    // Test case for when network call fails
    @MainActor
    func testLoadComicsDecoding() async throws {
        // Setup
        mockNetworkManager.returnDecodingError = true // Simulate failure
        let comicsService = ComicsService(networkManager: mockNetworkManager)
        let viewModel = ComicsListViewModel(comicsService: comicsService)
        
        // Action
        await viewModel.loadComics()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "No data available.")
        XCTAssertEqual(viewModel.comics.count, 0)
    }
    
    // Test case for when network call fails
    @MainActor
    func testLoadComicsFailure() async throws {
        // Setup
        mockNetworkManager.returnEmpty = true // Simulate failure
        let comicsService = ComicsService(networkManager: mockNetworkManager)
        let viewModel = ComicsListViewModel(comicsService: comicsService)
        
        // Action
        await viewModel.loadComics()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "No data available.")
        XCTAssertEqual(viewModel.comics.count, 0)
    }
}
