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
     
    var action: TopViewCellAction?
    
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
        maskedView.backgroundColor = .black
        maskedView.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackDetail: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, platformContainer, detailLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var likeButton: LikeButton = {
        let view = LikeButton(frame: .zero, image: UIImage(named: "ic_heart"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.didTapped = { [weak self] in
            if let data = self?.data {
                self?.action?.like(model: data)
            }
        }
        return view
    }()
    
    private lazy var shareButton: ImageSubLabelView = {
        let view = ImageSubLabelView(frame: .zero, image: UIImage(named: "ic_share"), showText: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.didTapped = { [weak self] in
            if let data = self?.data {
                self?.action?.share(model: data)
            }
        }
        return view
    }()
    
    private lazy var downloadButton: ImageSubLabelView = {
        let view = ImageSubLabelView(frame: .zero, image: UIImage(named: "ic_download"), showText: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.didTapped = { [weak self] in
            if let data = self?.data {
                self?.action?.save(model: data)
            }
        }
        return view
    }()
    
    private lazy var pauseImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "ic_play"))
        self.contentView.addSubview(image)
        image.alpha = 0
        image.tintColor = .white
        image.centerInSuperview(size: .init(width: 150, height: 150))
        return image
    }()
    
    private lazy var maskedView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func setupView() {
        setupConstrain()
        self.contentView.isUserInteractionEnabled = true
        let pauseGesture = UITapGestureRecognizer(target: self, action: #selector(handlePause))
        self.contentView.addGestureRecognizer(pauseGesture)
        
        let likeDoubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLikeGesture(sender:)))
        likeDoubleTapGesture.numberOfTapsRequired = 2
        self.contentView.addGestureRecognizer(likeDoubleTapGesture)
        
        pauseGesture.require(toFail: likeDoubleTapGesture)
    }
    
    private func setupConstrain() {
        setupmaskedView()
        setupDetailConstrain()
        setupActionConstrain()
    }
    
    private func setupmaskedView() {
        contentView.addSubview(maskedView)
        let bottomMaskedViewConstrain = [
            maskedView.heightAnchor.constraint(equalToConstant: 120),
            maskedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            maskedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            maskedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(bottomMaskedViewConstrain)
    }
    
    private func setupActionConstrain() {
        let actionContainer = UIStackView(arrangedSubviews: [starView, likeButton, shareButton, downloadButton])
        actionContainer.axis = .vertical
        actionContainer.alignment = .center
        actionContainer.spacing = 24
        actionContainer.distribution = .equalSpacing
        actionContainer.isUserInteractionEnabled = true
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
        let width = contentView.frame.width * 0.11
        let buttonHeight = width + likeButton.textLabel.frame.height + 8
        likeButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        shareButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        downloadButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        downloadButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
    
    private func setupDetailConstrain() {
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
        
        if let rating = data.star {
            starView.scoreLabel.text = "\(rating.rounded(toPlaces: 1))"
        } else {
            starView.scoreLabel.text = "0.0"
        }
        
        if let suggest = data.suggestionCount {
             likeButton.textLabel.text = "\(suggest)"
        } else {
             likeButton.textLabel.text = ""
        }
        
    }
    
    func hidePause() {
        pauseImageView.alpha = 0
    }
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupMaskedColor()
    }
    
    private func setupMaskedColor() {
           let gradientMaskLayer = CAGradientLayer()
           gradientMaskLayer.frame = maskedView.bounds
           
           gradientMaskLayer.colors = [UIColor.clear.cgColor,
                                       UIColor.black.withAlphaComponent(0.05).cgColor,
                                       UIColor.black.withAlphaComponent(0.2).cgColor,
                                       UIColor.black.withAlphaComponent(0.4).cgColor]
           gradientMaskLayer.locations = [0, 0.1, 0.3, 1]
           
           maskedView.layer.mask = gradientMaskLayer
       }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pauseImageView.alpha = 0
        data = nil
        videoLayer?.removeFromSuperlayer()
        platformContainer.removeAllArrangedSubviews()
        videoLayer = nil
    }
}

extension TopViewCell {
    
    @objc func handlePause() {
        if videoLayer?.player?.isPlaying == true {
            // Pause video and show pause sign
            videoLayer?.player?.pause()
            UIView.animate(withDuration: 0.075, delay: 0, options: .curveEaseIn, animations: { [weak self] in
                guard let self = self else { return }
                self.pauseImageView.alpha = 0.35
                self.pauseImageView.transform = CGAffineTransform.init(scaleX: 0.45, y: 0.45)
            })
        } else {
            // Start video and remove pause sign
            videoLayer?.player?.play()
            UIView.animate(withDuration: 0.075, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                guard let self = self else { return }
                self.pauseImageView.alpha = 0
                }, completion: { [weak self] _ in
                    self?.pauseImageView.transform = .identity
            })
        }
    }
    
    // Heart Animation with random angle
    @objc func handleLikeGesture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        let heartView = UIImageView(image: UIImage(named: "ic_heart"))
        heartView.tintColor = .systemPink
        let width: CGFloat = 110
        heartView.contentMode = .scaleAspectFit
        heartView.frame = CGRect(x: location.x - width / 2, y: location.y - width / 2, width: width, height: width)
        heartView.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -CGFloat.pi * 0.2...CGFloat.pi * 0.2))
        
        self.contentView.addSubview(heartView)
        UIView.animate(withDuration: 0.3, delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 3, options: [.curveEaseInOut], animations: {
                        heartView.transform = heartView.transform.scaledBy(x: 0.85, y: 0.85)
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 0.1,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 3, options: [.curveEaseInOut], animations: {
                            heartView.transform = heartView.transform.scaledBy(x: 2.3, y: 2.3)
                            heartView.alpha = 0
            }, completion: { _ in
                heartView.removeFromSuperview()
            })
        })
        likeButton.isLike = true
        if let data = data {
            action?.like(model: data)
        }
    }
}

protocol TopViewCellAction {
    func like(model: TopVideoGameModel)
    func share(model: TopVideoGameModel)
    func save(model: TopVideoGameModel)
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

extension AutoPlayVideoLayerContainer where Self: UICollectionViewCell {
    func playVideosFor() {
        VideoPlayerController.shared.playVideosFor(cell: self)
    }
    
    func pauseVideoFor() {
        VideoPlayerController.shared.pauseVideosFor(cell: self)
    }
}
