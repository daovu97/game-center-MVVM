//
//  BaseSelectedCell.swift
//  gamecenter
//
//  Created by daovu on 10/5/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class BaseSelectedCell: BaseCollectionViewCell {
    lazy var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: UIFont.primaryFontNameLight, size: 20)
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()
    
    override func setupView() {
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        setupConstrain()
    }
    
    open func setupConstrain() {}
    
    open func setSelected(isSelect: Bool = false) {
        contentView.backgroundColor = isSelect ? UIColor.systemPink : UIColor.white
    }
}
