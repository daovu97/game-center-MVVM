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
    var videoURL: String? {
        didSet {
            videoLayer.isHidden = videoURL == nil
        }
    }
    
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    
    override func setupView() {
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.videoGravity = .resizeAspect
        layer.addSublayer(videoLayer)
        videoLayer.frame = self.contentView.bounds
    }
    
    func configure(url: String) {
        self.videoURL = url
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
