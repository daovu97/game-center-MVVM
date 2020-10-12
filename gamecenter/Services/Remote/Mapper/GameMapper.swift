//
//  GameMapper.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

extension Game {
    func mapToTopGameModel() -> TopVideoGameModel {
        let platform = parentPlatforms?
            .compactMap { $0.platform?.mapToParrentPlatform() }
        
        let detail = genres?
            .compactMap { $0.name }
            .toString(with: ", ")
        
        let store = stores?
            .compactMap { StoreModel(id: $0.store?.id,
                                     name: $0.store?.name,
                                     domain: $0.store?.domain,
                                     urlEn: $0.urlEn,
                                     urlRu: $0.urlRu) }

        return TopVideoGameModel(id: id, name: name,
                                 star: rating, detail: detail,
                                 videoUrl: clip?.clip,
                                 backgroundImage: backgroundImage,
                                 platform: platform,
                                 suggestionCount: suggestionsCount,
                                 store: store)
    }
}

extension Platform {
    func mapToParrentPlatform() -> ParentPlatformModel {
        return ParentPlatformModel(id: id, name: name)
    }
}

extension Array where Element == String {
    func toString(with divider: String) -> String {
        var result = ""
        for (index, element) in self.enumerated() {
            if index == 0 {
                result += element
            } else {
                result += "\(divider)\(element)"
            }
        }
        return result
    }
}
