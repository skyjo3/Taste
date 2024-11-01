//
//  CollectionViewCell.swift
//  Taste
//
//  Created by amy on 2024-10-31.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "customCell"
    
    public let imageView: UIImageView!
    public let titleLabel: UILabel!
    public let subtitleLabel: UILabel!
    public let videoButton: UIButton!
    public let sourceButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width*2/3))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cellImageWidth/2
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 20))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRect(x: 0, y: 70, width: view.frame.width, height: 20))
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(subtitleLabel)
        
        videoButton = UIButton(frame: CGRect(x: 0, y: 90, width: view.frame.width/2, height: 40))
        videoButton.buttonType = .system
        videoButton.titleLabel?.text = "Video"
        videoButton.addTarget(self, action: #selector(videoButtonTapped), for: .touchUpInside)
        view?.addSubview(videoButton)
        
        sourceButton = UIButton(frame: CGRect(x: 0, y: 90, width: view.frame.width/2, height: 40))
        sourceButton.buttonType = .system
        sourceButton.titleLabel?.text = "Source"
        videoButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
        view?.addSubview(sourceButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented!")
    }
    
    func configure(with recipe: RecipeModel) {
        imageView.image = UIImage(named: "") // changed later
        titleLabel.text = recipe.name
        subtitleLabel.text = recipe.cuisine
        videoButton.description = recipe.videoURL
        sourceButton.description = recipe.sourceURL
    }
    
    @objc func videoButtonTapped(sender: UIButton) {
        print(sender.description)
    }
    
    @objc func sourceButtonTapped(sender: UIButton) {
        print(sender.description)
    }
}
