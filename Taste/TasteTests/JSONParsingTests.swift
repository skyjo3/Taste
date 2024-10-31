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
            guard let url = 
        }
    }
    
    func testParseJSON_Empty() {
        
    }
    
    func testParseJSON_Malformed() {
        
    }
}
