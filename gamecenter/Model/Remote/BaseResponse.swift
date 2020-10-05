//
//  BaseResponse.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [T]?

    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
        results = try values.decodeIfPresent([T].self, forKey: .results)
    }

}
