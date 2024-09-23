//
//  Moviez_Dashboard_UITests.swift
//  MoviezUITests
//
//  Created by Lord Jose Lopez on 23/09/24.
//

import XCTest

final class Moviez_Dashboard_UITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainDashboardNavigation() throws {
        
        
        let app = XCUIApplication()
        app.launch()
        
        let scrollViewsQuery = app.scrollViews.otherElements
        
        //Navigate through detail from Carousel
        scrollViewsQuery.collectionViews.images[AccessibilityIdentifiers.carouselMovieImage].tap()
        
        //Validate we have got the Movie details
        let movieDetailTitle = scrollViewsQuery.staticTexts[AccessibilityIdentifiers.movieDetailTitle].label
        XCTAssertEqual(movieDetailTitle, "Deadpool & Wolverine")
        //TODO: - Add element validation like this, to other elements

        //Return to dashboard
        let backButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        backButton.tap()
        
        let changeLayoutButton = scrollViewsQuery.buttons[AccessibilityIdentifiers.changeGridLayoutButton]
        changeLayoutButton.tap()
        scrollViewsQuery.buttons["Borderlands, Original Language, EN, Popularity"].staticTexts["EN"].tap()
        backButton.tap()
        
        changeLayoutButton.tap()
        scrollViewsQuery.containing(.staticText, identifier:"Trending movies...").children(matching: .other).element(boundBy: 1)/*@START_MENU_TOKEN@*/.staticTexts["Deadpool & Wolverine"]/*[[".buttons[\"Deadpool & Wolverine\"].staticTexts[\"Deadpool & Wolverine\"]",".staticTexts[\"Deadpool & Wolverine\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        backButton.tap()
        
        let sortMoviesButton = scrollViewsQuery.buttons[AccessibilityIdentifiers.sortingMoviesButton]
        sortMoviesButton.tap()
        scrollViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Alien: Romulus"]/*[[".buttons[\"Alien: Romulus\"].staticTexts[\"Alien: Romulus\"]",".staticTexts[\"Alien: Romulus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }

}

enum AccessibilityIdentifiers {
    static let carouselMovieImage = "Carousel Movie Image"
    static let movieDetailTitle = "Movie Detail Title"
    static let sortingMoviesButton = "Sort Movies Button"
    static let changeGridLayoutButton = "Change Movies View Layout"
}
