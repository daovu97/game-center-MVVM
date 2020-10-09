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
    private let pageSize = 5
    
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
        guard !(isLoading || !isConnectedToNetwork()) else { return }
        
        isLoading = true
        if !isLoadmore {
            showProgress()
        } else {
            currentPage += 1
        }
        
        let param = APIParam(parrentPlatforms: LocalDB.shared.getFavorPlatform(),
                             genres: LocalDB.shared.getFavorGenre(),
                             page: currentPage, dates: nil,
                             ordering: .relevance,
                             pageSize: pageSize)
        
        service.loadVideo(param: param) {[weak self] (games, error) in
            if let games = games, !games.isEmpty {
                
                let lastCount = self?.datas.count ?? 0
                self?.datas.append(contentsOf: games)
                self?.doLoadVideoWork(data: games)
                
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
