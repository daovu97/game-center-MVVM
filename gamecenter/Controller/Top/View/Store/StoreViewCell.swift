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
        label.textColor = .lightGray
        label.font = UIFont(name: primaryFontName_medium, size: 14)
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_store_steam")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func setupView() {
       
        contentView.addSubview(labelname)
        contentView.addSubview(image)
        
        let imageConstrain = [
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            image.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6)
        ]
        
        NSLayoutConstraint.activate(imageConstrain)
        
        labelname.anchor(top: image.bottomAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor)
    }
    
    func setupData(data: StoreModel) {
        labelname.text = data.name ?? ""
        image.image = data.icon
    }
}
