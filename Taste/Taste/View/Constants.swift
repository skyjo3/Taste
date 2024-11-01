//
//  Constants.swift
//  Taste
//
//  Created by amy on 2024-10-31.
//

import Foundation
import UIKit

let screenSize = UIScreen.main.bounds.size
let screenWidth = screenSize.width
let screenHeight = screenSize.height

// main page
let backgroundColor = UIColor.white

// navigation bar
let navigationBarColor = UIColor.white
let navigationBarButtonColor = UIColor.black

// collection view
let collectionBackgroundColor = UIColor.clear
let collectionMinLineSpacing = 20.0
let collectionMinInteritemSpacing = 10.0

// collection cell
let cellPadding = 20.0
let cellWidth = screenWidth-cellPadding*2
let cellHeight = cellImageHeight + cellTitleHeight + cellSubtitleHeight + cellButtonHeight + cellPadding*2

let cellImageWidth = 80.0
let cellImageHeight = screenWidth*2/3
let cellTitleHeight = 20.0
let cellSubtitleHeight = 20.0
let cellButtonHeight = 50.0

let cellIconImageWidth = 20.0

let cellTextXPosition = 100.0
let cellTextWidth = screenWidth
let cellCornerRadius = 20.0
