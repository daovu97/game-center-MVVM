//
//  Platforms.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

struct Platform : Codable {
    let id : Int?
    let name : String?
    let slug : String?
    let games_count : Int?
    let image_background : String?
    let image : String?
    let year_start : String?
    let year_end : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case slug = "slug"
        case games_count = "games_count"
        case image_background = "image_background"
        case image = "image"
        case year_start = "year_start"
        case year_end = "year_end"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        games_count = try values.decodeIfPresent(Int.self, forKey: .games_count)
        image_background = try values.decodeIfPresent(String.self, forKey: .image_background)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        year_start = try values.decodeIfPresent(String.self, forKey: .year_start)
        year_end = try values.decodeIfPresent(String.self, forKey: .year_end)
    }

}

