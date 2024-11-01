//
//  ListViewControllerTests.swift
//  TasteTests
//
//  Created by amy on 2024-10-31.
//

import XCTest
@testable import Taste

final class ListViewControllerTests: XCTestCase {

    func testDidUpdateRecipes_Empty() {
        let VC = ListViewController()
        _ = VC.view
        
        var RM = RecipeManager()
        RM.delegate = VC
        
        RM.delegate?.didUpdateRecipes(RM, recipes: [])
        XCTAssertEqual(VC.recipes.count, 0)
        
        DispatchQueue.main.async {
            XCTAssertTrue(VC.emptyView.isHidden == false)
        }
    }
    
    func testDidUpdateRecipes_NonEmpty() {
        let VC = ListViewController()
        _ = VC.view
        
        var RM = RecipeManager()
        RM.delegate = VC
        
        let recipes = [RecipeModel(name: "A", cuisine: "", imageURL: "", videoURL: "", sourceURL: ""),
                       RecipeModel(name: "B", cuisine: "", imageURL: "", videoURL: "", sourceURL: ""),
                       RecipeModel(name: "C", cuisine: "", imageURL: "", videoURL: "", sourceURL: ""),]
        
        RM.delegate?.didUpdateRecipes(RM, recipes: recipes)
        XCTAssertEqual(VC.recipes.count, 3)
        
        DispatchQueue.main.async {
            XCTAssertTrue(VC.emptyView.isHidden == true)
        }
    }
    
    func testDidFailWithError() {
        let VC = ListViewController()
        _ = VC.view
        
        var RM = RecipeManager()
        RM.delegate = VC
        let error = NSError(domain: "TestFailed", code: 100, userInfo: [NSLocalizedDescriptionKey: "Some error happened!"])
        
        RM.delegate?.didFailWithError(error: error)
        
        DispatchQueue.main.async {
            XCTAssertTrue(VC.emptyView.isHidden == false)
        }
    }
    
    func testSortButtonTapped() {
        let VC = ListViewController()
        _ = VC.view
        
        let expectation = expectation(description: "view and data loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
        
        let recipes = [RecipeModel(name: "Pancakes", cuisine: "Dutch", imageURL: "", videoURL: "", sourceURL: ""),
                       RecipeModel(name: "Dumplings", cuisine: "Chinese", imageURL: "", videoURL: "", sourceURL: ""),
                       RecipeModel(name: "Apple Pie", cuisine: "American", imageURL: "", videoURL: "", sourceURL: ""),
                       RecipeModel(name: "Chicken Don", cuisine: "Japanese", imageURL: "", videoURL: "", sourceURL: ""),
                       RecipeModel(name: "Samosa", cuisine: "Indian", imageURL: "", videoURL: "", sourceURL: ""),
                       RecipeModel(name: "Hamburger", cuisine: "American", imageURL: "", videoURL: "", sourceURL: ""),
                       RecipeModel(name: "Dim Sum", cuisine: "Chinese", imageURL: "", videoURL: "", sourceURL: ""),
                       RecipeModel(name: "Fried Chicken", cuisine: "American", imageURL: "", videoURL: "", sourceURL: "")
        ]
        
        VC.recipes = recipes
        XCTAssertEqual(VC.recipes.count, 8)
        XCTAssertEqual(VC.recipes[0].name, "Pancakes")
        XCTAssertEqual(VC.recipes[1].name, "Dumplings")
        XCTAssertEqual(VC.recipes[2].name, "Apple Pie")
        
        VC.sortButtonTapped()
        
        XCTAssertEqual(VC.recipes.count, 8)
        XCTAssertEqual(VC.groupedRecipes.count, 5)
        XCTAssertEqual(VC.groupedRecipes["American"]?.count, 3)
        XCTAssertEqual(VC.groupedRecipes["Chinese"]?.count, 2)
        XCTAssertEqual(VC.cuisineTypes.count, 5)
        XCTAssertEqual(VC.cuisineTypes[0], "American")
        XCTAssertEqual(VC.cuisineTypes[1], "Chinese")
        XCTAssertEqual(VC.cuisineTypes[2], "Dutch")
        XCTAssertEqual(VC.cuisineTypes[3], "Indian")
        XCTAssertEqual(VC.cuisineTypes[4], "Japanese")
    }
}
