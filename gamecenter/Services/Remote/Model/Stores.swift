//
//  File.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import UIKit

struct Stores: Codable {
    let id: Int?
    let store: Store?
    let urlEn: String?
    let urlRu: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case store = "store"
        case urlEn = "url_en"
        case urlRu = "url_ru"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        store = try values.decodeIfPresent(Store.self, forKey: .store)
        urlEn = try values.decodeIfPresent(String.self, forKey: .urlEn)
        urlRu = try values.decodeIfPresent(String.self, forKey: .urlRu)
    }
}

struct Store: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let domain: String?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case domain = "domain"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        domain = try values.decodeIfPresent(String.self, forKey: .domain)
        gamesCount = try values.decodeIfPresent(Int.self, forKey: .gamesCount)
        imageBackground = try values.decodeIfPresent(String.self, forKey: .imageBackground)
    }
}
