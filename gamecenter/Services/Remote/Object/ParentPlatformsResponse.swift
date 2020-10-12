//
//  File.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
struct ParentPlatformsResponse: Codable {
    let platform: Platform?

    enum CodingKeys: String, CodingKey {
        case platform
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        platform = try values.decodeIfPresent(Platform.self, forKey: .platform)
    }

}
