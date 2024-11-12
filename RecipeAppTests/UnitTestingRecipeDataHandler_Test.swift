//
//  UnitTestingRecipeDataHandler_Test.swift
//  RecipeAppTests
//
//  Created by Siddhant Gupta on 11/11/24.
//

import XCTest
@testable import RecipeApp

final class UnitTestingRecipeDataHandler_Test: XCTestCase {
    var dataHandler: RecipesDataHandler = RecipesDataHandler()
    var mockAPIHelper: MockAPIHelper = MockAPIHelper()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func getMockData(fileName: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: fileName, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
    
    func testFetchRecipesDataHandling_WithValidData_ShouldReturnSortedRecipes() async throws {
        mockAPIHelper.dataToReturn = getMockData(fileName: "Recipes")
        let sortedRecipes = try await dataHandler.handleData(data: mockAPIHelper.fetchData(from: "https://mock.api/recipes"))
        XCTAssertEqual(sortedRecipes["American"]?.count, 14)
        XCTAssertEqual(sortedRecipes["Canadian"]?.count, 5)
        XCTAssertEqual(sortedRecipes["Croatian"]?.count, 1)
    }
    
    func testFetchRecipesDataHandling_WithInvalidData_ShouldReturnEmptyDictionary() async throws {
        mockAPIHelper.dataToReturn = getMockData(fileName: "RecipesMalformed")
        let sortedRecipes = try await dataHandler.handleData(data: mockAPIHelper.fetchData(from: "https://mock.api/recipes"))
        XCTAssertTrue(sortedRecipes.isEmpty)
    }
    
    func testFetchRecipesDataHandling_WithEmptyData_ShouldReturnEmptyDictionary() async throws {
        mockAPIHelper.dataToReturn = getMockData(fileName: "RecipesEmpty")
        let sortedRecipes = try await dataHandler.handleData(data: mockAPIHelper.fetchData(from: "https://mock.api/recipes"))
        XCTAssertTrue(sortedRecipes.isEmpty)
    }

}
