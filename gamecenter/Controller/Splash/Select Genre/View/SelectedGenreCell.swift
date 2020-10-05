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
    
    func setupData(genre: GenreModel) {
        labelName.text = genre.name ?? ""
    }
    
    override func setSelected(isSelect: Bool = false) {
        super.setSelected(isSelect: isSelect)
        labelName.textColor = isSelect ? UIColor.white : UIColor.black
    }
}
