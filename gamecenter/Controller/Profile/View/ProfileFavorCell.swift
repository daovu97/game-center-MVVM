//
//  ProfileFavorCell.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileFavorCell: BaseCollectionViewCell {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "ic_game")
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var playImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_play_normal")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = .white
        return image
    }()
    
    private func setupConstrainImage() {
        contentView.addSubview(image)
        image.anchor(top: contentView.topAnchor,
                     leading: contentView.leadingAnchor,
                     bottom: contentView.bottomAnchor,
                     trailing: contentView.trailingAnchor)
        
        contentView.addSubview(playImage)
    }
    
    private func setupConstrainPlayButton() {
        playImage.anchor(top: nil,
                         leading: nil,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 6, right: 6),
                         size: .init(width: 30, height: 30))
        
        playImage.layer.shadowColor = UIColor.gray.cgColor
        playImage.layer.shadowOffset = .init(width: 0, height: 1)
        playImage.layer.shadowOpacity = 0.6
        playImage.layer.shadowRadius = 1.0
        playImage.clipsToBounds = false
    }
    
    override func setupView() {
        setupConstrainImage()
        setupConstrainPlayButton()
    }
    
    func setUpData(data: TopVideoGameModel) {
        if let backgroundImage = data.backgroundImage,
            let URL = URL(string: backgroundImage) {
            image.kf.setImage(with: URL)
        } else {
            image.image = UIImage(named: "ic_game")
        }
    }
}
