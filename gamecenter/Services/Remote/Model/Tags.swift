//
//  File.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
struct Tags: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let language: String?
    let games_count: Int?
    let image_background: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case language
        case games_count
        case image_background 
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        games_count = try values.decodeIfPresent(Int.self, forKey: .games_count)
        image_background = try values.decodeIfPresent(String.self, forKey: .image_background)
    }

}
