//
//  CuisineHeaderView.swift
//  Taste
//
//  Created by amy on 2024-11-01.
//

import UIKit

class CuisineHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "Header"
    
    @IBOutlet var textLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel = UILabel(frame: frame)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(textLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
