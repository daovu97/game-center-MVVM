//
//  SelectedGenreCell.swift
//  gamecenter
//
//  Created by daovu on 10/2/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SelectedGenreCell: BaseSelectedCell {
    
    override func setupConstrain() {
        setUpLabelName()
    }
    
    private func setUpLabelName() {
        contentView.addSubview(labelName)
        let constrain = [
            labelName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(constrain)
        
    }
    
    func setupData(genre: GenreModel, isSelect: Bool = false) {
        super.setSelected(isSelect: isSelect)
        labelName.text = genre.name ?? ""
        rounedWithShadown()
        labelName.textColor = isSelect ? UIColor.white : UIColor.black
    }
}

extension BaseSelectedCell {
    func rounedWithShadown() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
    }
}
