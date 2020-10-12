//
//  StoresHeaderView.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class StoresHeaderView: UICollectionReusableView {
    
    private var labelName: UILabel = {
        let label = UILabel()
        label.text = whereTobuy
        label.font = UIFont(name: primaryFontName_bold, size: 20)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        addSubview(labelName)
        labelName.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
