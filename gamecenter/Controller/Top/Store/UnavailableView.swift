//
//  UnavailableView.swift
//  gamecenter
//
//  Created by daovu on 10/9/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class UnavailableView: UIView {
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_unavailable_store")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .lightGray
        return image
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.text = "No store available"
        title.textColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let stack = UIStackView(arrangedSubviews: [image, title])
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 30
        addSubview(stack)
        stack.centerInSuperview()
        
        image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        image.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        
    }
}
