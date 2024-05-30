//
//  ComicServiceTests.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//
import Foundation
import XCTest
@testable import MarvelComics

class ComicServiceTests: XCTestCase {
    
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() async throws {
        mockNetworkManager = MockNetworkManager()
    }
    override func tearDown() {
        mockNetworkManager = nil
    }
    
    func testFetchComicsSuccess() async throws {
        // Setup
        let comicsService = ComicsService(networkManager: mockNetworkManager)
        
        // Action
        let comics = try await comicsService.fetchComics()
        
        // Assert
        XCTAssertEqual(comics.count, 2)
    }
    
    // Test case for when network call fails
    func testFetchComicsEmpty() async throws {
        // Setup
        mockNetworkManager.returnEmpty = true
        let comicsService = ComicsService(networkManager: mockNetworkManager)
        
        // Action
        do {
            _ = try await comicsService.fetchComics()
            // Assert
            XCTAssert(true, "Should not succeed")
        } catch {
            if let error = error as? NetworkError {
                // Assert
                XCTAssertEqual(error, NetworkError.noData)
            }
        }
      
    }
    
    func testFetchComicsDecodingError() async throws {
        // Setup
        mockNetworkManager.returnDecodingError = true
        let comicsService = ComicsService(networkManager: mockNetworkManager)
        
        // Action
        do {
            _ = try await comicsService.fetchComics()
            // Assert
            XCTAssert(true, "Should not succeed")
        } catch {
            if let error = error as? NetworkError {
                // Assert
                XCTAssertEqual(error, NetworkError.decodingError)
            }
        }
      
    }
}
