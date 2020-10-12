//
//  ProfileViewModel.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RxSwift

final class ProfileViewModel: BaseViewModel {
    var data = [TopVideoGameModel]()
    private var favorDb: FavorGameDBType = FavorGameDB()
    
    var collectionViewUpdate = PublishSubject<ScrollViewUpdate<TopVideoGameModel>>()
    
    func getFavorVideo() {
        favorDb.getListFavorGame {[weak self] (game) in
            self?.data = game ?? .init()
            self?.collectionViewUpdate.onNext(.reload)
        }
    }
    
    func presentVideo(at position: IndexPath) {
        SceneCoordinator.shared.transition(to: Scene.presentVideo(data: data, position: position.row))
    }
}
