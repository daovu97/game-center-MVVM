//
//  SelectPlatformViewModel.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import Combine

final class SelectPlatformViewModel: BaseSelectViewModel {
    
    private(set) var platforms = [ParentPlatformModel]()
    private let _collectionViewAupdate = PassthroughSubject<ScrollViewUpdate<ParentPlatformModel>, Never>()
    private(set) lazy var collectionViewAupdate = _collectionViewAupdate.eraseToAnyPublisher()
    
    func getPlatforms() {
        let value: BaseResponse<ParentPlatform>? = extractJson(from: "PlatformsData")
        platforms = (value?.results ?? .init()).map { $0.mapToParentPlatformModel()}
        _collectionViewAupdate.send(.reload)
    }
    
    override func setSelectedIndexPath(indexPath: IndexPath) {
        super.setSelectedIndexPath(indexPath: indexPath)
        _collectionViewAupdate.send(.reload)
    }
    
    func saveFavorPlatform() {
        var platforms = [ParentPlatformModel]()
        selectedIndexPath.forEach { platforms.append(self.platforms[$0.row]) }
        getLocalDB().savePlatform(platforms: platforms)
    }
    
}

enum ScrollViewUpdate<T> {
    case add(value: [T], position: [IndexPath])
    case reload
    case scrollTo(position: IndexPath)
    case reloadAt(position: [IndexPath])
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
