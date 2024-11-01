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
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width*2/3))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 50, width: self.frame.width, height: 20))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRect(x: 0, y: 70, width: self.frame.width, height: 20))
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(subtitleLabel)
        
        videoButton = UIButton(type: .system)
        videoButton.frame = CGRect(x: 0, y: 90, width: self.frame.width/2, height: 40)
        videoButton.titleLabel?.text = "Video"
        videoButton.addTarget(self, action: #selector(videoButtonTapped), for: .touchUpInside)
        self.addSubview(videoButton)
        
        sourceButton = UIButton(type: .system)
        sourceButton.frame = CGRect(x: 0, y: 90, width: self.frame.width/2, height: 40)
        sourceButton.titleLabel?.text = "Source"
        videoButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
        self.addSubview(sourceButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented!")
    }
    
    func configure(with recipe: RecipeModel) {
        
        titleLabel.text = recipe.name
        subtitleLabel.text = recipe.cuisine
        
        if let imageURL = recipe.imageURL {
            imageView.image = UIImage(named: "") // changed later
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
