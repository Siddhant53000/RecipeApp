//
//  UnitTestingAPIHelper_Test.swift
//  RecipeAppTests
//
//  Created by Siddhant Gupta on 11/11/24.
//

import XCTest
@testable import RecipeApp
final class UnitTestingAPIHelper_Test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchData_WithBadURL_ShouldThrowUnsupportedURLError() async {
        let apiHelper = APIHelper()
        let badURLString = "invalid_url" // An intentionally malformed URL
        
        do {
            let _ = try await apiHelper.fetchData(from: badURLString)
            XCTFail("Expected URLError.badURL but no error was thrown")
        } catch {
            // Assert that the error is URLError and the code is .badURL
            if let urlError = error as? URLError {
                XCTAssertEqual(urlError.code, .unsupportedURL, "Expected URLError.unsupportedURL but got \(urlError.code)")
            } else {
                XCTFail("Expected URLError.unsupportedURL but received a different error: \(error)")
            }
        }
    }


}
