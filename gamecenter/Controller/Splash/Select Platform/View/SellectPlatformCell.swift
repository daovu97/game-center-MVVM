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
    private lazy var iconHeight = contentView.frame.height * 6 / 10
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func setupIconImage() {
        contentView.addSubview(iconImage)
        iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: iconHeight).isActive = true
        iconWidthAnchor = iconImage.widthAnchor.constraint(equalToConstant: iconHeight)
        iconWidthAnchor.isActive = true
        iconImage.clipsToBounds = true
    }
    
    override func setupView() {
        contentView.layer.cornerRadius = 12.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        setupIconImage()
    }
    
    func setupData(platform: ParentPlatformModel) {
        setUpIconImage(image: platform.getIcon())
    }
    
    var isSelect: Bool = false {
        didSet {
            contentView.backgroundColor = isSelect ? UIColor.red : UIColor.white
        }
    }
    
    private func setUpIconImage(image: UIImage?) {
        guard let image = image else { return }
        let width = (iconHeight / image.size.height) * image.size.width
        iconWidthAnchor.constant = width
        iconImage.image = image
        
    }
}
