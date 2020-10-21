//
//  BaseSelectViewModel.swift
//  gamecenter
//
//  Created by daovu on 10/2/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import Combine

open class BaseSelectViewModel: BaseViewModel {
    private let _didSelectedItem = CurrentValueSubject<Bool, Never>(false)
    
    lazy var didSelectedItem = _didSelectedItem.eraseToAnyPublisher()
    
    var selectedIndexPath = Set<IndexPath>()
    
    func setSelectedIndexPath(indexPath: IndexPath) {
        if selectedIndexPath.contains(indexPath) {
            selectedIndexPath.remove(indexPath)
        } else {
            selectedIndexPath.insert(indexPath)
        }
        if selectedIndexPath.count > 1 {
            return
        }
        _didSelectedItem.send(!selectedIndexPath.isEmpty)
    }
    
    func gotoMain() {
        SceneCoordinator.shared.transition(to: Scene.top)
    }
    
    func gotoNext() {
        if self is SelectGenreViewModel {
            gotoMain()
        } else {
            SceneCoordinator.shared.transition(to: Scene.selectGenre(SelectGenreViewModel()))
        }
    }
    
    func getLocalDB() -> LocalDB {
        LocalDB.shared
    }
}
