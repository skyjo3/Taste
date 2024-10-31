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
        let tast = MockURLSessionDataTask {
            completionHandler(self.data, nil, self.error)
        }
        return task
    }
}

class MockRecipeManagerDelegate: RecipeManagerDelegate {
    var didUpdateRecipeCalled = false
    var didFailWithErrorCalled = false
    
    var receivedRecipes: [RecipeModel]?
    var receivedError = Error?
    
    func didUpdateRecipes(_ recipeManager: RecipeManager, recipes: [RecipeModel]) {
        didUpdateRecipeCalled = true
        receivedRecipes = recipes
    }
    
    func didFailWithError(_ error: any Error) {
        didFailWithErrorCalled = true
        receivedError = error
    }
}

final class MockNetworkTests: XCTestCase {

    func testFetchRecipes_Success() {
        let mockSession = MockURLSession()
        mockSession.data = Data()
        var manager = RecipeManager(session: mockSession)
        let delegate = MockRecipeManagerDelegate()
        manager.delegate = delegate
        
        manager.fetchRecipes(with: "fake url")
        
        XCTAssertTrue(delegate.didUpdateRecipeCalled)
        XCTAssertNotNil(delegate.receivedRecipes)
        
        XCTAssertFalse(delegate.didFailWithErrorCalled)
        XCTAssertNil(delegate.receivedError)
    }
    
    func testFetchRecipes_Failure() {
        let mockSession = MockURLSession()
        mockSession.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Network Error"])
        var manager = RecipeManager(session: mockSession)
        let delegate = MockRecipeManagerDelegate()
        manager.delegate = delegate
        
        manager.fetchRecipes(with: "fake url")
        
        XCTAssertTrue(delegate.didFailWithErrorCalled)
        XCTAssertNotNil(delegate.receivedError)
        
        XCTAssertFalse(delegate.didUpdateRecipeCalled)
        XCTAssertNil(delegate.receivedRecipes)
    }
}
