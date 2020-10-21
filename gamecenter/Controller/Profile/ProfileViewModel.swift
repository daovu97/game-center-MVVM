//
//  ProfileViewModel.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import Combine

final class ProfileViewModel: BaseViewModel {
    var data = [TopVideoGameModel]()
    private lazy var favorDb: FavorGameDBType = FavorGameDB()
    
    private let _collectionViewUpdate = PassthroughSubject<ScrollViewUpdate<TopVideoGameModel>, Never>()
    lazy var collectionViewUpdate = _collectionViewUpdate.eraseToAnyPublisher()
    
    func getFavorVideo() {
        favorDb.getListFavorGame {[weak self] (game) in
            self?.data = game ?? .init()
            self?._collectionViewUpdate.send(.reload)
        }
    }
    
    func presentVideo(at position: IndexPath) {
        guard !data.isEmpty else { return }
        SceneCoordinator.shared.transition(to: Scene.presentVideo(data: data, position: position.row))
    }
}
