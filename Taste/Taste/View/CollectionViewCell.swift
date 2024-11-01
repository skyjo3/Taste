//
//  CollectionViewCell.swift
//  Taste
//
//  Created by amy on 2024-10-31.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "customCell"
    
    private var containerView: UIView!
    
    public var imageView: UIImageView!
    public var titleLabel: UILabel!
    public var subtitleLabel: UILabel!
    public var videoButton: URLButton!
    public var sourceButton: URLButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = cellCornerRadius
        clipsToBounds = true
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellImageHeight))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: cellImageHeight+cellPadding*1, width: cellWidth, height: cellTitleHeight))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRect(x: 0, y: cellImageHeight+cellTitleHeight+cellPadding*1, width: cellWidth, height: cellSubtitleHeight))
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        subtitleLabel.textAlignment = .center
        self.addSubview(subtitleLabel)
        
        videoButton = URLButton(frame: CGRect(x: 0, y: cellImageHeight+cellTitleHeight+cellSubtitleHeight+cellPadding*2, width: cellWidth/2, height: cellButtonHeight))
        videoButton.setTitle("🎬 Video", for: .normal)
        videoButton.setTitleColor(.black, for: .normal)
        videoButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        videoButton.layer.borderColor = UIColor.white.cgColor
        videoButton.layer.borderWidth = 0.5
        videoButton.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.7, alpha: 1.0)
        videoButton.addTarget(self, action: #selector(videoButtonTapped), for: .touchUpInside)
        self.addSubview(videoButton)
        
        sourceButton = URLButton(frame: CGRect(x: cellWidth/2, y: cellImageHeight+cellTitleHeight+cellSubtitleHeight+cellPadding*2, width: cellWidth/2, height: cellButtonHeight))
        sourceButton.setTitle("🌐 Source", for: .normal)
        sourceButton.setTitleColor(.black, for: .normal)
        sourceButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sourceButton.layer.borderColor = UIColor.white.cgColor
        sourceButton.layer.borderWidth = 0.5
        sourceButton.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.7, alpha: 1.0)
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
            imageView.sd_setImage(with: URL(string: imageURL),
                                  placeholderImage: UIImage(named: "placeholder-image"))
        }
        if let videoURL = recipe.videoURL {
            videoButton.url = URL(string: videoURL)
        }
        if let sourceURL = recipe.sourceURL {
            sourceButton.url = URL(string: sourceURL)
        }
    }
    
    @objc func videoButtonTapped(sender: URLButton) {
        guard let url = sender.url else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func sourceButtonTapped(sender: URLButton) {
        guard let url = sender.url else { return }
        UIApplication.shared.open(url)
    }
}

class URLButton: UIButton {
    var url: URL?
}
