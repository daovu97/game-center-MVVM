//
//  FavorMapper.swift
//  gamecenter
//
//  Created by daovu on 10/9/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RealmSwift

extension List {
    func toArray<T>() -> [T] {
        return compactMap { $0 as? T }
    }
}

extension Array {
    func toList<T>() -> List<T> {
        let list = List<T>()
        forEach {
            if let element = $0 as? T {
                list.append(element)
            }
        }
        return list
    }
}

extension TopVideoGameObject {
    func mapToTopVideoGameModel() -> TopVideoGameModel {
        return TopVideoGameModel(id: id.value, name: name,
                                 star: star.value, detail: detail,
                                 videoUrl: videoUrl,
                                 platform: platform.toArray(),
                                 suggestionCount: suggestionCount.value,
                                 store: store.toArray())
    }
}

extension TopVideoGameModel {
    func mapToTopVideoGameObject() -> TopVideoGameObject {
        let object = TopVideoGameObject()
        object.id = RealmOptional(id)
        object.name = name
        object.detail = detail
        object.videoUrl = videoUrl
        object.platform = (platform ?? .init()).toList()
        object.suggestionCount = RealmOptional(suggestionCount)
        object.store = (store ?? .init()).toList()
        return object
    }
}

extension ParentPlatformObject {
    func mapToParentPlatformModel() -> ParentPlatformModel {
        return ParentPlatformModel(id: id.value, name: name)
    }
}

extension ParentPlatformModel {
    func mapToParentPlatformObject() -> ParentPlatformObject {
        let object = ParentPlatformObject()
        object.id = RealmOptional(id)
        object.name = name
        return object
    }
}

extension StoreObject {
    func mapToStoreModel() -> StoreModel {
        return StoreModel(id: id.value, name: name, domain: domain, urlEn: urlEn, urlRu: urlRu)
    }
}

extension StoreModel {
    func mapToStoreObject() -> StoreObject {
        let object = StoreObject()
        object.id = RealmOptional(id)
        object.name = name
        object.domain = domain
        object.urlEn = urlEn
        object.urlRu = urlRu
        return object
    }
}
