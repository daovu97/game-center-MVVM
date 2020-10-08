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
    
    private lazy var pauseImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "ic_play"))
        self.contentView.addSubview(image)
        image.alpha = 0
        image.tintColor = .white
        image.centerInSuperview(size: .init(width: 150, height: 150))
        return image
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
    
    func hidePause() {
        pauseImageView.alpha = 0
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
            delegate?.like(model: data)
        }
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

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

class GradianView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,
                                UIColor.black.withAlphaComponent(0.0).cgColor]
        gradientLayer.frame = frame
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
