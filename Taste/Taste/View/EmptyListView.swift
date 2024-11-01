//
//  EmptyListView.swift
//  Taste
//
//  Created by amy on 2024-10-31.
//

import UIKit

class EmptyListView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        imageView.center = self.center
        imageView.image = UIImage(systemName: "mail.and.text.magnifyingglass")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        
        let label = UITextView(frame: CGRectMake(0, 0, 200, 100))
        label.center = CGPoint(x: imageView.center.x, y: imageView.center.y+90)
        label.text = "No recipe at this moment.\n\nTry again later ;)"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        self.addSubview(label)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}
