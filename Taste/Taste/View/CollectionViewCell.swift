//
//  CollectionViewCell.swift
//  Taste
//
//  Created by amy on 2024-10-31.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "customCell"
    
    public var imageView: UIImageView!
    public var titleLabel: UILabel!
    public var subtitleLabel: UILabel!
    public var videoButton: UIButton!
    public var sourceButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: cellImageHeight))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: cellImageHeight, width: screenWidth, height: cellTitleHeight))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRect(x: 0, y: cellImageHeight+cellTitleHeight, width: screenWidth, height: cellSubtitleHeight))
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(subtitleLabel)
        
        videoButton = UIButton(frame: CGRect(x: 0, y: cellImageHeight+cellTitleHeight+cellSubtitleHeight, width: screenWidth/2, height: cellButtonHeight))
        videoButton.setTitle("Video", for: .normal)
        videoButton.tintColor = .black
        videoButton.backgroundColor = .blue
        videoButton.addTarget(self, action: #selector(videoButtonTapped), for: .touchUpInside)
        self.addSubview(videoButton)
        
        sourceButton = UIButton(frame: CGRect(x: screenWidth/2, y: cellImageHeight+cellTitleHeight+cellSubtitleHeight, width: screenWidth/2, height: cellButtonHeight))
        sourceButton.setTitle("Source", for: .normal)
        sourceButton.tintColor = .black
        sourceButton.backgroundColor = .green
        sourceButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
        self.addSubview(sourceButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented!")
    }
    
    func configure(with recipe: RecipeModel) {
        
        titleLabel.text = recipe.name
        subtitleLabel.text = recipe.cuisine
        
        if let imageURL = recipe.imageURL {
            imageView.image = UIImage(systemName: "circle") // changed later
        }
        if let videoURL = recipe.videoURL {
            videoButton.userActivity?.webpageURL = URL(string: videoURL)
        }
        if let sourceURL = recipe.sourceURL {
            sourceButton.userActivity?.webpageURL = URL(string: sourceURL)
        }
    }
    
    @objc func videoButtonTapped(sender: UIButton) {
        print(sender.userActivity?.webpageURL)
    }
    
    @objc func sourceButtonTapped(sender: UIButton) {
        print(sender.userActivity?.webpageURL)
    }
}
