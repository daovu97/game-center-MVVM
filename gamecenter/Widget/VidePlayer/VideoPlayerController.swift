//
//  VideoPlayerController.swift
//  gamecenter
//
//  Created by daovu on 10/6/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import AVFoundation

protocol AutoPlayVideoLayerContainer {
    var videoURL: String? { get set }
    var videoLayer: AVPlayerLayer? { get set }
}

class VideoPlayerController: NSObject, NSCacheDelegate {
    
    static private var playerViewControllerKVOContext = 0
    static let shared = VideoPlayerController()
    var preferredPeakBitRate: Double = 1000000
    
    private var videoURL: String?
    
    private var observingURLs = [String: Bool]()
    // Cache of player and player item
    private var videoCache = NSCache<NSString, VideoPlayerContainer>()
    
    // Current AVPlapyerLayer that is playing video
    private var currentLayer: AVPlayerLayer?
    
    override init() {
        super.init()
        videoCache.delegate = self
    }
    
    /**
     Download of an asset of url if corresponding videocontainer
     is not present.
     Uses the asset to create new playeritem.
     */
    func setupVideoFor(url: String) {
        if self.videoCache.object(forKey: url as NSString) != nil {
            return
        }
        guard let URL = URL(string: url) else {
            return
        }
        print(url)
        let asset = AVURLAsset(url: URL)
        let requestedKeys = ["playable"]
        asset.loadValuesAsynchronously(forKeys: requestedKeys) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            var error: NSError?
            let status = asset.statusOfValue(forKey: "playable", error: &error)
            switch status {
            case .loaded:
                break
            case .failed, .cancelled:
                print("Failed to load asset successfully")
                return
            default:
                print("Unkown state of asset")
                return
            }
            let player = AVPlayer()
            let item = AVPlayerItem(asset: asset)
            DispatchQueue.main.async {
                let videoContainer = VideoPlayerContainer(player: player, item: item, url: url)
                strongSelf.videoCache.setObject(videoContainer, forKey: url as NSString)
                videoContainer.player.replaceCurrentItem(with: videoContainer.playerItem)

                if strongSelf.videoURL == url, let layer = strongSelf.currentLayer {
                    strongSelf.playVideo(withLayer: layer, url: url)
                }
            }
        }
    }
    
    func playVideo(withLayer layer: AVPlayerLayer, url: String) {
        videoURL = url
        currentLayer = layer
        if let videoContainer = self.videoCache.object(forKey: url as NSString) {
            layer.player = videoContainer.player
            videoContainer.playOn = true
            addObservers(url: url, videoContainer: videoContainer)
        }
    }
    
    private func pauseVideo(forLayer layer: AVPlayerLayer, url: String) {
//        videoURL = nil
//        currentLayer = nil
        if let videoContainer = self.videoCache.object(forKey: url as NSString) {
            videoContainer.playOn = false
            layer.player?.seek(to: .zero)
            removeObserverFor(url: url)
        }
    }
    
    //Loop Play video again in case the current player has finished playing
    @objc func playerDidFinishPlaying(note: NSNotification) {
        guard let playerItem = note.object as? AVPlayerItem,
            let currentPlayer = currentVideoContainer()?.player else {
                return
        }
        if let currentItem = currentPlayer.currentItem, currentItem == playerItem {
            currentPlayer.seek(to: .zero)
            currentPlayer.play()
        }
    }
    
    private func currentVideoContainer() -> VideoPlayerContainer? {
        if let currentVideoUrl = videoURL {
            if let videoContainer = videoCache.object(forKey: currentVideoUrl as NSString) {
                return videoContainer
            }
        }
        return nil
    }
    
    func pauseVideosFor(cell: UICollectionViewCell) {
        if let cell = cell as? AutoPlayVideoLayerContainer,
            let videoCellURL = cell.videoURL, let videoLayer = cell.videoLayer {
            self.pauseVideo(forLayer: videoLayer, url: videoCellURL)
        }
    }
    
    func playVideosFor(cell: UICollectionViewCell) {
        if let cell = cell as? AutoPlayVideoLayerContainer,
            let videoCellURL = cell.videoURL, let videoLayer = cell.videoLayer {
             self.playVideo(withLayer: videoLayer, url: videoCellURL)
        }
    }
    
    // Set observing urls false when objects are removed from cache
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        if let videoObject = obj as? VideoPlayerContainer {
            observingURLs[videoObject.url] = false
        }
    }
    
    deinit {
        
    }
}

// MARK: - KVO
extension VideoPlayerController {
    private func removeObserverFor(url: String) {
        if let videoContainer = self.videoCache.object(forKey: url as NSString) {
            if let currentItem = videoContainer.player.currentItem, observingURLs[url] == true {
                currentItem.removeObserver(self,
                                           forKeyPath: "status",
                                           context: &VideoPlayerController.playerViewControllerKVOContext)
                NotificationCenter.default.removeObserver(self,
                                                          name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                          object: currentItem)
                observingURLs[url] = false
            }
        }
    }
    
    private func addObservers(url: String, videoContainer: VideoPlayerContainer) {
        if self.observingURLs[url] == false || self.observingURLs[url] == nil {
            videoContainer.player
                .currentItem?
                .addObserver(self,
                             forKeyPath: "status",
                             options: [.new, .initial],
                             context: &VideoPlayerController.playerViewControllerKVOContext)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.playerDidFinishPlaying(note:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: videoContainer.player.currentItem)
            self.observingURLs[url] = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?, change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard context == &VideoPlayerController.playerViewControllerKVOContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        if keyPath == "status" {
            let newStatus: AVPlayerItem.Status
            if let newStatusAsNumber = change?[NSKeyValueChangeKey.newKey] as? NSNumber {
                newStatus = AVPlayerItem.Status(rawValue: newStatusAsNumber.intValue)!
                if newStatus == .readyToPlay {
                    guard let item = object as? AVPlayerItem,
                        let currentItem = currentVideoContainer()?.player.currentItem else {
                            return
                    }
                    if item == currentItem && currentVideoContainer()?.playOn == true {
                        currentVideoContainer()?.playOn = true
                    }
                }
            } else {
                newStatus = .unknown
            }
            if newStatus == .failed {
                
            }
        }
    }
}
