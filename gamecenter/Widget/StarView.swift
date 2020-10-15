//
//  StarView.swift
//  gamecenter
//
//  Created by daovu on 10/7/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class StarView: UIView {
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "1.1"
        label.textColor = .systemPink
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
        addSubview(scoreLabel)
        scoreLabel.centerInSuperview(size: .init(width: frame.size.width, height: frame.size.height / 1.3))
        scoreLabel.font = UIFont(name: UIFont.primaryFontNameBold, size: 16)
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = .init(width: 0, height: 1)
        layer.shadowOpacity = 0.6
        layer.shadowRadius = frame.height / 2
        clipsToBounds = false
    }
}
