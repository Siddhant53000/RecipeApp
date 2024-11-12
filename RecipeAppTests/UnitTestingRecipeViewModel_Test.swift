//
//  UnitTestingRecipeViewModel_Test.swift
//  RecipeAppTests
//
//  Created by Siddhant Gupta on 11/11/24.
//

import XCTest
@testable import RecipeApp
final class UnitTestingRecipeViewModel_Test: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchRecipes_WithBadURL_ShouldReturnEmptyDictionary() async {
        let badURLString = "invalid_url" // An intentionally malformed URL
        let recipeViewModel = await RecipeViewModel(urlString: badURLString)
        XCTAssert(recipeViewModel.recipesList.isEmpty)
    }
    func testFetchRecipes_WithEmptyURL_ShouldReturnEmptyDictionary() async {
        let badURLString = "" // An intentionally malformed URL
        let recipeViewModel = await RecipeViewModel(urlString: badURLString)
        XCTAssert(recipeViewModel.recipesList.isEmpty)
    }

}
