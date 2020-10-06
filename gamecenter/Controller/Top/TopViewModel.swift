//
//  TopViewModel.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RxSwift

final class TopViewModel: BaseViewModel {
    var videoTemp = [
        "https://media.rawg.io/media/stories/92d/92d070309b4ad98aa48ec6f15eb44259.mp4",
        "https://media.rawg.io/media/stories/777/77738935b59ea443752c783743fb8175.mp4",
        "https://media.rawg.io/media/stories/c33/c3340048fb5377bb6858bca7a42d2705.mp4",
        "https://media.rawg.io/media/stories-640/87d/87d4e1f282c61630795c5436515a073a.mp4",
        "https://media.rawg.io/media/stories-640/7d9/7d9f5184eef081acbbe06b91b7237d01.mp4",
        "https://media.rawg.io/media/stories-640/285/285fbb732e5b7905369bfee93859e881.mp4",
        "https://media.rawg.io/media/stories-640/769/7697a34ae4d841ea14a84cbde41bfad6.mp4"]
    
    var videos = [String]()
    var collectionViewUpdate = PublishSubject<ScrollViewUpdate<String>>()
    
    func getVideo() {
        let lastCount = videos.count
        videos.append(contentsOf: videoTemp)
        for index in lastCount...videos.count - 1 {
            VideoPlayerController.shared.setupVideoFor(url: videos[index])
        }
        collectionViewUpdate.onNext(.reload)
    }
    
    func setUpVideoData() {
        videos.forEach { VideoPlayerController.shared.setupVideoFor(url: $0) }
    }
}
