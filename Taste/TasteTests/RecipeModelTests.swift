//
//  RecipeModelTests.swift
//  TasteTests
//
//  Created by amy on 2024-10-31.
//

import XCTest
@testable import Taste

final class RecipeModelTests: XCTestCase {

    func testInitialization() {
        let recipe = RecipeModel(name: "Bubble Tea",
                                 cuisine: "Taiwanese",
                                 imageURL: "https://assets.epicurious.com/photos/629f98926e3960ec24778116/3:2/w_6819,h_4546,c_limit/BubbleTea_RECIPE_052522_34811.jpg",
                                 videoURL: "https://youtu.be/CU-WVa-f1Lo?si=5RpeW9kODs9BxsHy",
                                 sourceURL: "http://www.angelwongskitchen.com")
        
        XCTAssertEqual(recipe.name, "Bubble Tea")
        XCTAssertEqual(recipe.cuisine, "Taiwanese")
        XCTAssertEqual(recipe.imageURL, "https://assets.epicurious.com/photos/629f98926e3960ec24778116/3:2/w_6819,h_4546,c_limit/BubbleTea_RECIPE_052522_34811.jpg")
        XCTAssertEqual(recipe.videoURL, "https://youtu.be/CU-WVa-f1Lo?si=5RpeW9kODs9BxsHy")
        XCTAssertEqual(recipe.sourceURL, "http://www.angelwongskitchen.com")
    }
}
