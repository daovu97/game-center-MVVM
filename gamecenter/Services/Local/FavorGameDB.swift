//
//  FavorGameDB.swift
//  gamecenter
//
//  Created by daovu on 10/9/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RealmSwift

class TopVideoGameObject: Object {
    var id = RealmOptional<Int>()
    @objc dynamic var name: String? = nil
    var star = RealmOptional<Double>()
    @objc dynamic var detail: String? = nil
    @objc dynamic var videoUrl: String? = nil
    var platform = List<ParentPlatformObject>()
    var suggestionCount = RealmOptional<Int>()
    var store = List<StoreObject>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class ParentPlatformObject: Object {
    var id = RealmOptional<Int>()
    @objc dynamic var name: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class StoreObject: Object {
    var id = RealmOptional<Int>()
    @objc dynamic var name: String? = nil
    @objc dynamic var domain: String? = nil
    @objc dynamic var urlEn: String? = nil
    @objc dynamic var urlRu: String? = nil
}

protocol FavorGameDBType {
    func saveFavorGame(game: TopVideoGameModel)
    func getListFavorGame(completion: (([TopVideoGameModel]) -> Void)?)
    func getListFavorIdGame(completion: (([String]) -> Void)?)
}

struct FavorGameDB: FavorGameDBType {
    func saveFavorGame(game: TopVideoGameModel) {
        
    }
    
    func getListFavorGame(completion: (([TopVideoGameModel]) -> Void)?) {
        
    }
    
    func getListFavorIdGame(completion: (([String]) -> Void)?) {
        
    }
}
