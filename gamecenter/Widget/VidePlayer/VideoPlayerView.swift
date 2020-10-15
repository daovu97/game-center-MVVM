//
//  VideoPlayerView.swift
//  gamecenter
//
//  Created by daovu on 10/13/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    private var videoURL: URL?
    private var asset: AVURLAsset?
    private var playerItem: AVPlayerItem?
    private lazy var avPlayerLayer: AVPlayerLayer = {
        let  videoLayer = AVPlayerLayer()
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.videoGravity = .resizeAspectFill
        return videoLayer
    }()
    
    private var player: AVQueuePlayer?
    private var playerLoop: AVPlayerLooper?
    
    private var observer: NSKeyValueObservation?
    
    weak var delegate: VideoPlayerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        avPlayerLayer.frame = self.layer.bounds
    }
    
    private func setupView() {
        self.layer.addSublayer(self.avPlayerLayer)
    }
    
    func configure(url: String?) {
        guard let url = url, let URL = URL(string: url) else {
            print("URL Error from Tableview Cell")
            return
        }
        videoURL = URL
        if let data = VideoCacheManager.shared.queryDataFromCache(for: url) {
            asset = data
            playerItem = AVPlayerItem(asset: asset!)
            addObserverToPlayerItem()
            if let player = player {
                player.replaceCurrentItem(with: playerItem)
            } else {
                player = AVQueuePlayer(playerItem: playerItem)
            }
            playerLoop = AVPlayerLooper(player: player!, templateItem: playerItem!)
            avPlayerLayer.player = player
        } else {
            asset = AVURLAsset(url: URL)
            let requestedKeys = ["playable"]
            asset!.loadValuesAsynchronously(forKeys: requestedKeys) { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                var error: NSError?
                let status = strongSelf.asset!.statusOfValue(forKey: "playable", error: &error)
                switch status {
                case .loaded:
                    VideoCacheManager.shared.storeDataToCache(data: strongSelf.asset!, key: url)
                case .failed, .cancelled:
                    return
                default:
                    return
                }
                
                DispatchQueue.main.async {
                    strongSelf.playerItem = AVPlayerItem(asset: strongSelf.asset!)
                    strongSelf.addObserverToPlayerItem()
                    if let player = strongSelf.player {
                        player.replaceCurrentItem(with: strongSelf.playerItem)
                    } else {
                        strongSelf.player = AVQueuePlayer(playerItem: strongSelf.playerItem)
                    }
                    strongSelf.playerLoop = AVPlayerLooper(player: strongSelf.player!,
                                                           templateItem: strongSelf.playerItem!)
                    strongSelf.avPlayerLayer.player = strongSelf.player
                }
            }
        }
    }
    
    func replay() {
        self.player?.seek(to: .zero)
        play()
    }
    
    func play() {
        self.player?.play()
    }
    
    func pause() {
        self.player?.pause()
    }
    
    func cancelAllLoadingRequest() {
        removeObserver()
        videoURL = nil
        asset = nil
        playerItem = nil
        avPlayerLayer.player = nil
    }
}

// MARK: - KVO
extension VideoPlayerView {
   private func removeObserver() {
        if let observer = observer {
            observer.invalidate()
        }
    
    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                              object: playerItem)
    }
    
    private func addObserverToPlayerItem() {
        // Register as an observer of the player item's status property
        self.observer = self.playerItem!.observe(\.status,
                                                 options: [.initial, .new],
                                                 changeHandler: { [weak self] item, _ in
            let status = item.status
            // Switch over the status
            switch status {
            case .readyToPlay:
                // Player item is ready to play.
                self?.delegate?.readyToPlay()
                print("Status: readyToPlay")
            case .failed:
                // Player item failed. See error.
                print("Status: failed Error: " + item.error!.localizedDescription )
            case .unknown:
                // Player item is not yet ready.bn m
                print("Status: unknown")
            @unknown default:
                fatalError("Status is not yet ready to present")
            }
        })
    }
}
