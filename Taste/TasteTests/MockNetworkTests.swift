//
//  TasteTests.swift
//  TasteTests
//
//  Created by amy on 2024-10-31.
//

import XCTest
@testable import Taste

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}

class MockURLSession: URLSession {
    var data: Data?
    var error: Error?
    
    override func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        let task = MockURLSessionDataTask {
            completionHandler(self.data, nil, self.error)
        }
        return task
    }
}

class MockRecipeManagerDelegate: RecipeManagerDelegate {
    var didUpdateRecipeCalled = false
    var didFailWithErrorCalled = false
    
    var receivedRecipes: [RecipeModel]?
    var receivedError: Error?
    
    func didUpdateRecipes(_ recipeManager: RecipeManager, recipes: [RecipeModel]) {
        didUpdateRecipeCalled = true
        receivedRecipes = recipes
    }
    
    func didFailWithError(error: any Error) {
        didFailWithErrorCalled = true
        receivedError = error
    }
}

final class MockNetworkTests: XCTestCase {

    func testFetchRecipes_Success() {
        let mockSession = MockURLSession()
        mockSession.data = """
        {
        "recipes": [
        {
        "cuisine": "Malaysian",
        "name": "Apam Balik",
        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        }
        ]
        }
        """.data(using: .utf8)
        var manager = RecipeManager(session: mockSession)
        let delegate = MockRecipeManagerDelegate()
        manager.delegate = delegate
        
        manager.fetchRecipes(with: "https://google.com")
        
        XCTAssertTrue(delegate.didUpdateRecipeCalled)
        XCTAssertNotNil(delegate.receivedRecipes)
    }
    
    func testFetchRecipes_Failure_InvalidURL() {
        let mockSession = MockURLSession()
        var manager = RecipeManager(session: mockSession)
        let delegate = MockRecipeManagerDelegate()
        manager.delegate = delegate
        
        manager.fetchRecipes(with: "invalid_url")
        
        XCTAssertTrue(delegate.didFailWithErrorCalled)
        XCTAssertEqual(delegate.receivedError?.localizedDescription, "The request does not return any data.")
    }
    
    func testFetchRecipes_Failure_NetworkError() {
        let mockSession = MockURLSession()
        mockSession.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Network Error"])
        var manager = RecipeManager(session: mockSession)
        let delegate = MockRecipeManagerDelegate()
        manager.delegate = delegate
        
        manager.fetchRecipes(with: "https://google.com")
        
        XCTAssertTrue(delegate.didFailWithErrorCalled)
        XCTAssertEqual(delegate.receivedError?.localizedDescription, "Network Error")
    }
    
    func testFetchRecipes_Failure_NoData() {
        let mockSession = MockURLSession()
        mockSession.data = """
        {
        123
        }
        """.data(using: .utf8)
        var manager = RecipeManager(session: mockSession)
        let delegate = MockRecipeManagerDelegate()
        manager.delegate = delegate
        
        manager.fetchRecipes(with: "https://google.com")
        
        XCTAssertTrue(delegate.didFailWithErrorCalled)
        XCTAssertNotNil(delegate.receivedError?.localizedDescription, "The data couldn't be read because it isn't in the correct format.")
    }
}
