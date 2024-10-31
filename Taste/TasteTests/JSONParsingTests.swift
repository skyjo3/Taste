//
//  JSONParsingTests.swift
//  TasteTests
//
//  Created by amy on 2024-10-31.
//

import XCTest
@testable import Taste

final class JSONParsingTests: XCTestCase {

    var sut: RecipeModel! = nil
    
    override func setUp() {
        super.setUp()
        sut = RecipeModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testParseJSON_Valid() {
        self.measure {
            guard let url = Bundle.main.url(forResource: "valid", withExtension: "json") else {
                XCTFail("Failed to load valid.json")
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let results = sut.parseJSON(data)
                XCTAssertEqual(results.count, 63)
                
                // first item
                XCTAssertEqual(results[0].name, "Apam Balik")
                XCTAssertEqual(results[0].cuisine, "Malaysian")
                XCTAssertEqual(results[0].photo_url_small, "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
                
                // last item
                XCTAssertEqual(results[62].name, "White Chocolate Crème Brûlée")
                XCTAssertEqual(results[62].cuisine, "French")
                XCTAssertEqual(results[62].photo_url_small,  "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/small.jpg")
                
                // item somewhere in the middle
                XCTAssertEqual(results[4].name, "Banana Pancakes")
                XCTAssertEqual(results[4].cuisine, "American")
                XCTAssertEqual(results[4].photo_url_small, "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg")
            } catch {
                XCTFail("Failed to decode json file: \(error)")
            }
        }
    }
    
    func testParseJSON_Empty() {
        guard let url = Bundle(for: type(of: self)).url(forResource: "empty", withExtension: "json") else {
            XCTFail("Failed to load empty.json")
            return
        }
        let data = try Data(contentsOf: url)
        let results = sut.parseJSON(data)
        XCTAssertEqual(results.count, 0)
    }
    
    func testParseJSON_Malformed() {
        guard let url = Bundle(for: type(of: self)).url(forResource: "malformed", withExtension: "json") else {
            XCTFail("Failed to load malformed.json")
            return
        }
        let data = try Data(contentsOf: url)
        let results = sut.parseJSON(data)
        XCTAssertEqual(results.count, 0)
    }
}
