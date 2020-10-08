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
    var datas = [TopVideoGameModel]()
    private var isLoading: Bool = false
    let dataTemp = [
        TopVideoGameModel(id: 1, name: "Fall Guys: Ultimate Knockout", star: 4.4,
                          detail: "Action, Casual",
                          videoUrl: "https://media.rawg.io/media/stories/92d/92d070309b4ad98aa48ec6f15eb44259.mp4",
                          platform: [ParentPlatformModel(id: 1, name: "PC"),
                                     ParentPlatformModel(id: 2, name: "PlayStation")]),
        TopVideoGameModel(id: 1, name: "Animal Crossing: New Horizons", star: 4.6,
                          detail: "Action, Casual, Sports",
                          videoUrl: "https://media.rawg.io/media/stories/777/77738935b59ea443752c783743fb8175.mp4",
                          platform: [ParentPlatformModel(id: 1, name: "PC"),
                                     ParentPlatformModel(id: 2, name: "PlayStation")]),
        TopVideoGameModel(id: 1, name: "Mafia III: Definitive Edition", star: 4.6,
                          detail: "Action, Casual, Sports",
                          videoUrl: "https://media.rawg.io/media/stories/c33/c3340048fb5377bb6858bca7a42d2705.mp4",
                          platform: [ParentPlatformModel(id: 1, name: "PC"),
                                     ParentPlatformModel(id: 2, name: "PlayStation")]),
        TopVideoGameModel(id: 1, name: "DOOM Eternal", star: 4.2,
                          detail: "Action, Casual, Sports, Arcade",
                          videoUrl: "https://media.rawg.io/media/stories-640/87d/87d4e1f282c61630795c5436515a073a.mp4",
                          platform: [ParentPlatformModel(id: 1, name: "PC"),
                                     ParentPlatformModel(id: 2, name: "PlayStation"),
                                     ParentPlatformModel(id: 3, name: "Xbox"),
                                     ParentPlatformModel(id: 7, name: "Nintendo"),
                                     ParentPlatformModel(id: 8, name: "")]),
        TopVideoGameModel(id: 1, name: "Fall Guys: Ultimate Knockout", star: 3.9,
                          detail: "Action, Casual, Sports",
                          videoUrl: "https://media.rawg.io/media/stories-640/7d9/7d9f5184eef081acbbe06b91b7237d01.mp4",
                          platform: [ParentPlatformModel(id: 1, name: "PC"),
                                     ParentPlatformModel(id: 2, name: "PlayStation")]),
        TopVideoGameModel(id: 1, name: "Mafia II: Definitive Edition", star: 4.0,
                          detail: "Action, Casual, Adventure",
                          videoUrl: "https://media.rawg.io/media/stories-640/285/285fbb732e5b7905369bfee93859e881.mp4",
                          platform: [ParentPlatformModel(id: 1, name: "PC"),
                                     ParentPlatformModel(id: 2, name: "PlayStation"),
                                     ParentPlatformModel(id: 2, name: "PlayStation")]),
        TopVideoGameModel(id: 1, name: "Ori and the Will of the Wisps", star: 4.6,
                          detail: "Action, Sports, Shooter",
                          videoUrl: "https://media.rawg.io/media/stories-640/769/7697a34ae4d841ea14a84cbde41bfad6.mp4",
                          platform: [ParentPlatformModel(id: 1, name: "PC"),
                                     ParentPlatformModel(id: 2, name: "PlayStation")])
    ]
    
    var collectionViewUpdate = PublishSubject<ScrollViewUpdate<TopVideoGameModel>>()
    
    private var callBackWhenLoaded:(() -> Void)?
    
    private func doLoadVideoWork(data: [TopVideoGameModel]) {
        var dataTemp = data
        callBackWhenLoaded = { [weak self] in
            dataTemp.remove(at: 0)
            if dataTemp.isEmpty {
                return
            } else {
                VideoPlayerController.shared.setupVideoFor(url: dataTemp[0].videoUrl, loaded: self?.callBackWhenLoaded)
            }
            
        }
        VideoPlayerController.shared.setupVideoFor(url: dataTemp[0].videoUrl, loaded: self.callBackWhenLoaded)
    }
    
    func getVideo(isLoadmore: Bool = false) {
        if isLoading {
            return
        }
        isLoading = true
        if !isLoadmore {
            showProgress()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
            let lastCount = self?.datas.count ?? 0
            self?.datas.append(contentsOf: self?.dataTemp ?? [TopVideoGameModel]())
            var addIndexPath = [IndexPath]()
            
            for index in lastCount...(self?.datas.count ?? 1) - 1 {
                addIndexPath.append(IndexPath(row: index, section: 0))
            }
            
            self?.doLoadVideoWork(data: self?.dataTemp ?? [TopVideoGameModel]())
            
            if isLoadmore {
                self?.collectionViewUpdate.onNext(.add(value: .init(), position: addIndexPath))
            } else {
                self?.collectionViewUpdate.onNext(.reload)
            }
            self?.hideProgress()
            self?.isLoading = false
        }
    }
}
