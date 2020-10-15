//
//  SelectPlatformHeaderView.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SelectPlatformHeaderView: UICollectionReusableView {
    
    static let titleSize = CGFloat(34)
    static let subTitleSize = CGFloat(12)
    
    private lazy var titleName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.primaryFontNameBold, size: SelectPlatformHeaderView.titleSize)
        label.text = Titles.selectPlatformHeaderTitle
        label.numberOfLines = 0
        label.textColor = .systemPink
        return label
    }()
    
    private lazy var subTitleName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.primaryFontNameLight, size: SelectPlatformHeaderView.subTitleSize)
        label.text = Titles.subSelectHeaderTitle
        label.numberOfLines = 1
        label.textColor = .lightGray
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
        addSubview(subTitleName)
        titleName.anchor(top: topAnchor,
                         leading: leadingAnchor, bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        subTitleName.anchor(top: titleName.bottomAnchor,
                            leading: titleName.leadingAnchor,
                            bottom: nil,
                            trailing: titleName.trailingAnchor,
                            padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    func setTitle(title: String = Titles.selectPlatformHeaderTitle) {
        titleName.text = title
    }
}
