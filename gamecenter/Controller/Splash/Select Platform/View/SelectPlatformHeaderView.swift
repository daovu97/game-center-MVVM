//
//  SelectPlatformHeaderView.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

let selectPlatformHeaderTitle = "Choose your favorite Platforms"
let primaryFontName = "Helvetica Neue"

class SelectPlatformHeaderView: UICollectionReusableView {
    
    private lazy var titleName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: primaryFontName, size: 40)
        label.text = selectPlatformHeaderTitle
        label.numberOfLines = 0
        label.textColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(titleName)
        titleName.anchor(top: topAnchor,
                         leading: leadingAnchor, bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 12, left: 12, bottom: 0, right: 12))
    }
}
