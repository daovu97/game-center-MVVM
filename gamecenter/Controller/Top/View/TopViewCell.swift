//
//  TopViewCell.swift
//  gamecenter
//
//  Created by daovu on 10/5/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import AVFoundation

class TopViewCell: BaseCollectionViewCell {
    
    private lazy var videoView: VideoView = {
        let videoView = VideoView()
        return videoView
    }()
    
    override func setupView() {
        contentView.addSubview(videoView)
        videoView.fillSuperview()
    }
    
    func configure(url: String) {
        videoView.configure(url: URL(string: url))
        videoView.play()
    }
    
    override func prepareForReuse() {
        videoView.cancelAllLoadingRequest()
    }
}
