//
//  ProfileheaderView.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class ProfileheaderView: UICollectionReusableView {
    
    private let imageProfile: UIImageView = {
        let image = UIImageView(image: UIImage(named: "ic_game"))
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .center
        image.backgroundColor = .lightGray
        return image
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: primaryFontName_bold, size: 18)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "Name"
        return label
    }()
    
    private let labelBio: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: primaryFontName_light, size: 16)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "Like action game"
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
    
    private func setupLabelNameConstrain() {
        addSubview(labelName)
        labelName.anchor(top: imageProfile.bottomAnchor,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 12, left: 8, bottom: 0, right: 8))
    }
    
    private func setupBioLabel() {
        addSubview(labelBio)
        labelBio.translatesAutoresizingMaskIntoConstraints = false
        let constrain = [
            labelBio.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelBio.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 8),
            labelBio.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelBio.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constrain)
    }
    
    private func setUpView() {
        setupConstrainImagePriflie()
        setupLabelNameConstrain()
        setupBioLabel()
    }
    
    private func setupConstrainImagePriflie() {
        addSubview(imageProfile)
        let constrain = [
            imageProfile.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageProfile.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageProfile.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            imageProfile.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
            
        ]
        
        NSLayoutConstraint.activate(constrain)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2
        imageProfile.layer.masksToBounds = true
    }
}
