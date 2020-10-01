//
//  SellectPlatformCell.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SellectPlatformCell: BaseCollectionViewCell {
    
    private var iconWidthAnchor: NSLayoutConstraint!
    private lazy var iconHeight = contentView.frame.height * 7 / 10
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var background: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 6
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupIconImage() {
        contentView.addSubview(iconImage)
        iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: iconHeight).isActive = true
        iconWidthAnchor = iconImage.widthAnchor.constraint(equalToConstant: 40)
        iconWidthAnchor.isActive = true
        iconImage.clipsToBounds = true
    }
    
    override func setupView() {
        contentView.addSubview(background)
        background.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        background.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        background.widthAnchor.constraint(equalToConstant: contentView.frame.width - 8).isActive = true
        background.heightAnchor.constraint(equalToConstant: contentView.frame.height - 8).isActive = true
        setupIconImage()
    }
    
    func setupData(platform: ParentPlatformModel) {
        setUpIconImage(image: platform.getIcon())
    }
    
    private func setUpIconImage(image: UIImage?) {
        guard let image = image else { return }
        let width = (iconHeight / image.size.height) * image.size.width
        iconWidthAnchor.constant = width
        iconImage.image = image
        
    }
}
