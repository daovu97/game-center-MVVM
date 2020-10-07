//
//  TopViewCell.swift
//  gamecenter
//
//  Created by daovu on 10/5/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import AVFoundation

class TopViewCell: BaseCollectionViewCell, AutoPlayVideoLayerContainer {
    
    private var data: TopVideoGameModel?
    // MARK: - Video Layer
    var videoURL: String? {
        didSet {
            videoLayer?.isHidden = videoURL == nil
        }
    }
    
    var videoLayer: AVPlayerLayer?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "God of wars"
        label.textColor = .white
        label.font = UIFont(name: primaryFontName_medium, size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: primaryFontName_medium, size: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var platformContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var starView: StarView = {
        let view = StarView()
        return view
    }()
    
    private var stackDetail: UIStackView!
    
    private lazy var likeButton: LikeButton = {
        let view = LikeButton(frame: .zero, image: UIImage(named: "ic_heart"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.didTapped = { [weak self] in
            if let data = self?.data {
                self?.delegate?.like(model: data)
            }
        }
        return view
    }()
    
    private lazy var shareButton: ImageSubLabelView = {
        let view = ImageSubLabelView(frame: .zero, image: UIImage(named: "ic_share"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.didTapped = { [weak self] in
            if let data = self?.data {
                self?.delegate?.share(model: data)
            }
        }
        return view
    }()
    
    private lazy var downloadButton: ImageSubLabelView = {
        let view = ImageSubLabelView(frame: .zero, image: UIImage(named: "ic_download"), showText: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.didTapped = { [weak self] in
            if let data = self?.data {
                self?.delegate?.save(model: data)
            }
        }
        return view
    }()
    
    override func setupView() {
        setupConstrain()
    }
    
    private func setupConstrain() {
        setupDetailConstrain()
        setupActionConstrain()
    }
    
    private func setupActionConstrain() {
        let actionContainer = UIStackView(arrangedSubviews: [starView, likeButton, shareButton, downloadButton])
        actionContainer.axis = .vertical
        actionContainer.alignment = .center
        actionContainer.spacing = 24
        actionContainer.distribution = .equalSpacing
        contentView.addSubview(actionContainer)
        actionContainer.anchor(top: nil, leading: nil,
                               bottom: contentView.bottomAnchor,
                               trailing: contentView.trailingAnchor,
                               padding: .init(top: 0, left: 8, bottom: 16, right: 8))
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.11).isActive = true
        starView.heightAnchor.constraint(equalTo: starView.widthAnchor, multiplier: 1).isActive = true
        
        setupActionButton()
    }
    
    private func setupActionButton() {
        let width = contentView.frame.width * 0.12
        let buttonHeight = width + likeButton.textLabel.frame.height + 8
        likeButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        shareButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        downloadButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        downloadButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
    
    private func setupDetailConstrain() {
        stackDetail = UIStackView(arrangedSubviews: [nameLabel, platformContainer, detailLabel])
        stackDetail.axis = .vertical
        stackDetail.spacing = 8
        stackDetail.alignment = .leading
        stackDetail.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackDetail)
        let platformConstrain = [
            platformContainer.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(platformConstrain)
        
        let stackDetailConstrain = [
            stackDetail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackDetail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackDetail.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
        ]
        NSLayoutConstraint.activate(stackDetailConstrain)
    }
    
    func configure(data: TopVideoGameModel) {
        self.data = data
        self.videoURL = data.videoUrl
        videoLayer = AVPlayerLayer()
        videoLayer!.backgroundColor = UIColor.clear.cgColor
        videoLayer!.videoGravity = .resizeAspectFill
        layer.insertSublayer(videoLayer!, at: 0)
        videoLayer!.frame = self.contentView.bounds
        
        if let name = data.name {
            nameLabel.isHidden = false
            nameLabel.text = name
        } else {
            nameLabel.isHidden = true
        }
        
        if let detail = data.detail {
            detailLabel.isHidden = false
            detailLabel.text = detail
        } else {
            detailLabel.isHidden = true
        }
        
        if let platforms = data.platform, !platforms.isEmpty {
            addPlatformIcon(platforms: platforms)
        } else {
            platformContainer.isHidden = true
        }
        
    }
    
    var delegate: TopViewCellAction?
    
    private func addPlatformIcon(platforms: [ParentPlatformModel]) {
        platformContainer.isHidden = false
        platforms.forEach { (platform) in
            if let icon = platform.type?.icon {
                platformContainer.addArrangedSubview(platformIcon(icon: icon))
            }
        }
    }
    
    private func platformIcon(icon: UIImage) -> UIImageView {
        let height = CGFloat(18)
        let width = icon.size.width / icon.size.height * height
        let image = UIImageView(frame: .init(x: 0, y: 0, width: width, height: height))
        image.image = icon
        image.tintColor = .white
        return image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        data = nil
        videoLayer?.removeFromSuperlayer()
        platformContainer.removeAllArrangedSubviews()
        videoLayer = nil
    }
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

protocol TopViewCellAction {
    func like(model: TopVideoGameModel)
    func share(model: TopVideoGameModel)
    func save(model: TopVideoGameModel)
}
