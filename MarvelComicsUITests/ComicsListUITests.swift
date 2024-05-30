//
//  ComicsListUITests.swift
//  MarvelComicsUITests
//
//  Created by Christian Curiel on 5/30/24.
//

import XCTest

final class ComicsListUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTapOnComicListItem() throws {
        let comicsList = app.collectionViews["comicsList"]
        XCTAssertTrue(comicsList.waitForExistence(timeout: 10))
        let firstComic = comicsList.cells.firstMatch
        XCTAssertTrue(firstComic.waitForExistence(timeout: 5))
        firstComic.tap()
        let detailView = app.scrollViews["comicDetailView"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 5))
    }
    
    func testDragToRefresh() throws {
        let comicsList = app.collectionViews["comicsList"]
        XCTAssertTrue(comicsList.waitForExistence(timeout: 10))
        
        let firstCell = comicsList.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 45.0))
        start.press(forDuration: 0, thenDragTo: finish)
        
        let refreshedCell = comicsList.cells.element(boundBy: 0)
        XCTAssertTrue(refreshedCell.waitForExistence(timeout: 5))
        
    }
    
    func testSearchAndTapFirstResult() throws {
        let comicsList = app.collectionViews["comicsList"]
        XCTAssertTrue(comicsList.waitForExistence(timeout: 10))
        
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        
        searchField.tap()
        searchField.typeText("Spider-Man")

        let firstResult = comicsList.cells.firstMatch
        XCTAssertTrue(firstResult.waitForExistence(timeout: 5))
        
        firstResult.tap()
        
        let detailView = app.scrollViews["comicDetailView"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 5))
    }
    
}
extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 0.5)
    }
}
