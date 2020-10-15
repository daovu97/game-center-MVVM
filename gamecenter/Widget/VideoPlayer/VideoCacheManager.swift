//
//  VideoCacheManager.swift
//  gamecenter
//
//  Created by daovu on 10/13/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import AVFoundation

class VideoCacheManager: NSObject, NSCacheDelegate {
    // VideoCacheManager is a singleton
    static let shared: VideoCacheManager = {
        return VideoCacheManager.init()
    }()
    
    private var videoCache = NSCache<NSString, AVURLAsset>()
    
    func storeDataToCache(data: AVURLAsset, key: String) {
        videoCache.setObject(data, forKey: key as NSString)
    }
    
    func queryDataFromCache(for key: String?) -> AVURLAsset? {
        guard let key = key else { return nil }
        return videoCache.object(forKey: key as NSString)
    }
}
