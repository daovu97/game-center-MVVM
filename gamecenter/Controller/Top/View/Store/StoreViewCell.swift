//
//  StoreViewCell.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class StoreViewCell: BaseCollectionViewCell {
    
    private lazy var labelname: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.font = UIFont(name: UIFont.primaryFontNameMedium, size: 14)
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Image.storeSteam.name)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func setupView() {
       
        contentView.addSubview(labelname)
        contentView.addSubview(image)
        
        let imageConstraint = [
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            image.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6)
        ]
        
        NSLayoutConstraint.activate(imageConstraint)
        
        labelname.anchor(top: image.bottomAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor)
    }
    
    func setupData(data: StoreModel) {
        labelname.text = data.name ?? ""
        image.image = data.icon
        contentView.alpha = (data.urlEn == nil || data.urlEn!.isEmpty) ? 0.3 : 1
    }
}
