//
//  SelectPlatformViewModel.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RxSwift

final class SelectPlatformViewModel: BaseSelectViewModel {
    
    var platforms = [ParentPlatformModel]()
    var collectionViewAupdate = PublishSubject<ScrollViewUpdate<ParentPlatformModel>>()
    
    func getPlatforms() {
        let value: BaseResponse<ParentPlatform>? = extractJson(from: "PlatformsData")
        platforms = (value?.results ?? .init()).map { $0.mapToParentPlatformModel()}
        collectionViewAupdate.onNext(.reload)
    }
    
    override func setSelectedIndexPath(indexPath: IndexPath) {
        super.setSelectedIndexPath(indexPath: indexPath)
        collectionViewAupdate.onNext(.reload)
    }
    
    func gotoSelectGenre() {
        SceneCoordinator.shared.transition(to: Scene.selectGenre(SelectGenreViewModel()))
    }
    
}

enum ScrollViewUpdate<T> {
    case add(value: [T], position: [IndexPath])
    case reload
}

func extractJson<T: Decodable>(from resource: String) -> T? {
    if let path = Bundle.main.url(forResource: resource, withExtension: "json") {
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            return nil
        }
    }
    return nil
}
