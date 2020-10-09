//
//  VideoPlayerView.swift
//  gamecenter
//
//  Created by daovu on 10/5/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerContainer: NSDiscardableContent {
    var url: String
    var appEnteredFromBackground: Bool = false
    var playOn: Bool {
        didSet {
            playerItem.preferredPeakBitRate = VideoPlayerController.shared.preferredPeakBitRate
            if playOn && playerItem.status == .readyToPlay {
                player.play()
            } else {
                player.seek(to: .zero)
                player.pause()
            }
        }
    }
    
    let player: AVPlayer
    let playerItem: AVPlayerItem
    
    init(player: AVPlayer, item: AVPlayerItem, url: String) {
        self.player = player
        self.playerItem = item
        self.url = url
        playOn = false
    }
    
    func beginContentAccess() -> Bool {
        return true
    }
    
    func endContentAccess() {
        
    }
    
    func discardContentIfPossible() {
        
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
}
