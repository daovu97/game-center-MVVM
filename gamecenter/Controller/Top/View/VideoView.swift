//
//  VideoView.swift
//  gamecenter
//
//  Created by daovu on 10/5/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import AVFoundation

class VideoView: UIView {
    var videoURL: URL?
    var originalURL: URL?
    var asset: AVAsset?
    var playerItem: AVPlayerItem?
    var avPlayerLayer: AVPlayerLayer!
    var playerLooper: AVPlayerLooper! // should be defined in class
    var queuePlayer: AVQueuePlayer?
    
    private var cancelLoadingQueue: DispatchQueue?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        cancelLoadingQueue = DispatchQueue.init(label: "com.cancelLoadingQueue")
        avPlayerLayer = AVPlayerLayer(player: queuePlayer)
    }
    
    func configure(url: URL?) {
        guard let url = url else {
            print("URL Error from Collection Cell")
            return
        }
        
        self.originalURL = url
        videoURL = url
        
        print(self.videoURL?.absoluteString)
        
        self.asset = AVAsset(url: self.videoURL!)
        //        self.asset!.resourceLoader.setDelegate(self, queue: .main)
        
        self.playerItem = AVPlayerItem(asset: self.asset!)
        //        self.addObserverToPlayerItem()
        
        if let queuePlayer = self.queuePlayer {
            queuePlayer.replaceCurrentItem(with: self.playerItem)
        } else {
            self.queuePlayer = AVQueuePlayer(playerItem: self.playerItem)
        }
        
        self.playerLooper = AVPlayerLooper(player: self.queuePlayer!, templateItem: self.queuePlayer!.currentItem!)
        self.avPlayerLayer.player = self.queuePlayer
        layer.addSublayer(avPlayerLayer)
        avPlayerLayer.frame = self.layer.bounds

    }
    
    func replay() {
        self.queuePlayer?.seek(to: .zero)
        play()
    }
    
    func play() {
        self.queuePlayer?.play()
    }
    
    func pause() {
        self.queuePlayer?.pause()
    }
    
    func cancelAllLoadingRequest() {
//           removeObserver()
           
           videoURL = nil
           originalURL = nil
           asset = nil
           playerItem = nil
           avPlayerLayer.player = nil
           playerLooper = nil
           
           cancelLoadingQueue?.async { [weak self] in
               self?.asset?.cancelLoading()
           }

       }
}
