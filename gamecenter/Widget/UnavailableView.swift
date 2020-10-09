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
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.white.withAlphaComponent(0.7)
        title.textAlignment = .center
        title.font = UIFont(name: primaryFontName_light, size: 16)
        image.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var detailLabel: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.numberOfLines = 0
        title.textAlignment = .center
        title.font = UIFont(name: primaryFontName_light, size: 14)
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
        let labelStack = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        labelStack.alignment = .center
        labelStack.axis = .vertical
        labelStack.distribution = .equalSpacing
        labelStack.spacing = 12
        let stack = UIStackView(arrangedSubviews: [image, labelStack])
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 30
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        image.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        
    }
}
