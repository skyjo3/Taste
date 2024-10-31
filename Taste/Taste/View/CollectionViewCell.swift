//
//  CollectionViewCell.swift
//  Taste
//
//  Created by amy on 2024-10-31.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "customCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented!")
    }
    
    func configure() {
        
    }
}
