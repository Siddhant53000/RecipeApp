//
//  MockAPIHelper.swift
//  RecipeApp
//
//  Created by Siddhant Gupta on 11/11/24.
//

import Foundation
@testable import RecipeApp

class MockAPIHelper: APIHelper {
    var dataToReturn: Data?
    var errorToThrow: Error?
    
    override func fetchData(from urlString: String) async throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        if let data = dataToReturn {
            return data
        }
        throw URLError(.badServerResponse)
    }
}
