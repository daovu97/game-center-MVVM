//
//  FavorGameDB.swift
//  gamecenter
//
//  Created by daovu on 10/9/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RealmSwift

private let realmBackground = "realmBackground"

protocol FavorGameDBType {
    func saveFavorGame(game: TopVideoGameModel)
    func getListFavorGame(completion: (([TopVideoGameModel]?) -> Void)?)
    func isLike(with id: Int?) -> Bool
}

struct FavorGameDB: FavorGameDBType {
    
    func isLike(with id: Int?) -> Bool {
        guard let id = id else { return false }
        let realm = try? Realm()
        return realm?.object(ofType: TopVideoGameObject.self, forPrimaryKey: id)?.isLike == true
    }
    
    private let background = DispatchQueue(label: realmBackground, qos: .background)
    func saveFavorGame(game: TopVideoGameModel) {
        background.async {
            let realm = try? Realm()
            do {
                try realm?.write {
                    realm?.add(game.mapToTopVideoGameObject(), update: .all)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getListFavorGame(completion: (([TopVideoGameModel]?) -> Void)?) {
        background.async {
            let realm = try? Realm()
            if let result = realm?.objects(TopVideoGameObject.self).filter({ $0.isLike == true }) {
                completion?(Array(result).compactMap { $0.mapToTopVideoGameModel() })
            } else {
                completion?(nil)
            }
        }
    }
}
