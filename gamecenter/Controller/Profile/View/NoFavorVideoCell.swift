//
//  NoFavorVideoCell.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class NoFavorVideoCell: BaseCollectionViewCell {
    
    private lazy var labelDetail: UILabel = {
        let label = UILabel()
        label.text = Titles.noFavoriteLabel
        label.numberOfLines = 0
        label.font = UIFont(name: primaryFontName_medium, size: 16)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    override func setupView() {
        contentView.addSubview(labelDetail)
        labelDetail.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
}
