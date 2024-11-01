//
//  CollectionDataSourceTests.swift
//  TasteTests
//
//  Created by amy on 2024-10-31.
//

import XCTest
@testable import Taste

final class CollectionDataSourceTests: XCTestCase {

    func testNumberOfCells() {
        let VC = ListViewController()
        _ = VC.view // force view load

        VC.recipes = [RecipeModel(name: "", cuisine: "", imageURL: "", videoURL: "", sourceURL: ""),
                      RecipeModel(name: "", cuisine: "", imageURL: "", videoURL: "", sourceURL: ""),
                      RecipeModel(name: "", cuisine: "", imageURL: "", videoURL: "", sourceURL: "")]

        VC.collectionView.reloadData()

        XCTAssertEqual(VC.collectionView.numberOfItems(inSection: 0), 3)
    }
    
    func testCellConfiguration() {
        let cell = CollectionViewCell()
        let recipe = RecipeModel(name: "Sushi", cuisine: "Japanese", imageURL: "image.url", videoURL: "video.url", sourceURL: "source.url")
        
        cell.configure(with: recipe)
        
        XCTAssertEqual(cell.titleLabel.text, recipe.name)
        XCTAssertEqual(cell.subtitleLabel.text, recipe.cuisine)
        if let videoURL = recipe.videoURL {
            XCTAssertEqual(cell.videoButton.url, URL(string: videoURL))
        }
        if let sourceURL = recipe.sourceURL {
            XCTAssertEqual(cell.sourceButton.url, URL(string: sourceURL))
        }
    }
}
