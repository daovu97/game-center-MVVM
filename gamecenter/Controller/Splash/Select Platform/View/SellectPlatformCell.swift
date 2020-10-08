//
//  SellectPlatformCell.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SellectPlatformCell: BaseSelectedCell {
    
    private var iconWidthAnchor: NSLayoutConstraint!
    private lazy var iconHeight = CGFloat(20)
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func setupConstrain() {
        setupIconImage()
        setUpLabelName()
    }
    
    private func setupIconImage() {
        contentView.addSubview(iconImage)
        iconWidthAnchor = iconImage.widthAnchor.constraint(equalToConstant: iconHeight)
        let constrain = [
            iconWidthAnchor!,
            iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: iconHeight),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(constrain)
        
        iconImage.clipsToBounds = true
    }
    
    private func setUpLabelName() {
        contentView.addSubview(labelName)
        let constrain = [
            iconWidthAnchor!,
            labelName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelName.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(constrain)
        
    }
    
    func setupData(platform: ParentPlatformModel, isSelect: Bool = false) {
        super.setSelected(isSelect: isSelect)
        labelName.textColor = isSelect ? UIColor.white : UIColor.black
        iconImage.tintColor = isSelect ? UIColor.white : UIColor.systemPink
        setUpIconImage(image: platform.type?.icon)
        labelName.text = platform.name ?? ""
        rounedWithShadown()
    }
    
    private func setUpIconImage(image: UIImage?) {
        guard let image = image else { return }
        let width = (iconHeight / image.size.height) * image.size.width
        iconWidthAnchor.constant = width
        iconImage.image = image
        
    }
}
