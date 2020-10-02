//
//  ParentPlatform.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

struct ParentPlatform: Codable {
    let id: Int?
    let name: String?
    let slug: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
    }

}

extension ParentPlatform {
    func mapToParentPlatformModel() -> ParentPlatformModel {
        return ParentPlatformModel(id: id, name: name)
    }
}
