//
//  File.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
struct Ratings: Codable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case count
        case percent
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        percent = try values.decodeIfPresent(Double.self, forKey: .percent)
    }

}
