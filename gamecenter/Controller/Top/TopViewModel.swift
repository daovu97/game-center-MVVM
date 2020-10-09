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
    private let service: APIServiceType = APIService()
    private var currentPage = 1
    private var isLoading: Bool = false
    private let pageSize = 10
    
    var datas = [TopVideoGameModel]()
    
    var collectionViewUpdate = PublishSubject<ScrollViewUpdate<TopVideoGameModel>>()
    
    private var callBackWhenLoaded:(() -> Void)?
    
    private func doLoadVideoWork(data: [TopVideoGameModel]) {
        guard !data.isEmpty else { return }
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
        } else {
            currentPage += 1
        }
        
        let param = APIParam(parrentPlatforms: nil,
                             page: currentPage, dates: nil,
                             ordering: .relevance,
                             pageSize: pageSize)
        
        service.loadVideo(param: param) {[weak self] (games, error) in
            if let games = games {
                guard !games.isEmpty else { return }
                let response = games.map { (game) -> TopVideoGameModel in
                    game.mapToTopGameModel()
                }
                
                let lastCount = self?.datas.count ?? 0
                
                self?.datas.append(contentsOf: response)
                self?.doLoadVideoWork(data: response)
                
                var addIndexPath = [IndexPath]()
                
                for index in lastCount...(self?.datas.count ?? 1) - 1 {
                    addIndexPath.append(IndexPath(row: index, section: 0))
                }
                
                if isLoadmore {
                    self?.collectionViewUpdate.onNext(.add(value: .init(), position: addIndexPath))
                } else {
                    self?.collectionViewUpdate.onNext(.reload)
                }
            }
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            self?.hideProgress()
            self?.isLoading = false
        }
    }
}
