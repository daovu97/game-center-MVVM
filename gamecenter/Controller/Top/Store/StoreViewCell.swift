//
//  StoreViewCell.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class StoreViewCell: BaseCollectionViewCell {
    
    private let labelname: UILabel = {
       let label = UILabel()
        return label
    }()
    
    override func setupView() {
        contentView.backgroundColor = .white
        contentView.addSubview(labelname)
        labelname.centerInSuperview()
    }
    
    func setupData(data: Stores) {
        labelname.text = data.store?.name ?? ""
    }
}
