//
//  SelectedGenreCell.swift
//  gamecenter
//
//  Created by daovu on 10/2/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SelectedGenreCell: BaseCollectionViewCell {
    
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: primaryFontName_light, size: 20)
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()
    
    override func setupView() {
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
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
    
    var isSelect: Bool = false {
        didSet {
            contentView.backgroundColor = isSelect ? UIColor.red : UIColor.white
            labelName.textColor = isSelect ? UIColor.white : UIColor.black
        }
    }
}
