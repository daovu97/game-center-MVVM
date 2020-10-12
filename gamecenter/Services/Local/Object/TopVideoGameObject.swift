//
//  TopVideoGameObject.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RealmSwift

class TopVideoGameObject: Object {
    var id = RealmOptional<Int>()
    @objc dynamic var name: String?
    var star = RealmOptional<Double>()
    @objc dynamic var detail: String?
    @objc dynamic var videoUrl: String?
    @objc dynamic var backgroundImage: String?
    var platform = List<ParentPlatformObject>()
    var suggestionCount = RealmOptional<Int>()
    var store = List<StoreObject>()
    @objc dynamic var isLike: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class ParentPlatformObject: Object {
    var id = RealmOptional<Int>()
    @objc dynamic var name: String?
}

class StoreObject: Object {
    var id = RealmOptional<Int>()
    @objc dynamic var name: String?
    @objc dynamic var domain: String?
    @objc dynamic var urlEn: String?
    @objc dynamic var urlRu: String?
}
