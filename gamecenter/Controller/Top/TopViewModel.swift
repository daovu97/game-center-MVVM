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
    var topViewControllerType: TopViewControllerType = .top
    
    private var respository: TopVideoGameRespositoryType = TopVideoGameRespository()
    
    var collectionViewUpdate = PublishSubject<ScrollViewUpdate<TopVideoGameModel>>()
    
    var shouldShowbackButton = BehaviorSubject<Bool>(value: false)
    
    func getVideo(isLoadmore: Bool = false) {
        guard topViewControllerType == .top else {
            return
        }
        
        guard !(isLoading || !isConnectedToNetwork()) else { return }
        
        isLoading = true
        if !isLoadmore {
            showProgress()
        }
        
        respository.getGame(isLoadMore: isLoadmore) { [weak self] (games, error) in
            if let games = games, !games.isEmpty {
                let lastCount = self?.datas.count ?? 0
                self?.datas.append(contentsOf: games)
                
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
    
    func likeVideo(isLike: Bool, position: Int) {
        datas[position].isLike = isLike
        respository.likeGame(gameModel: datas[position])
    }
    
    func setUpPresentData(datas: [TopVideoGameModel], position: Int) {
        shouldShowbackButton.onNext(true)
        topViewControllerType = .present
        self.datas = datas
        respository.loadVideoWork(data: datas)
        collectionViewUpdate.onNext(.scrollTo(position: IndexPath(row: position, section: 0)))
    }
    
    enum TopViewControllerType {
        case top
        case present
    }
}
