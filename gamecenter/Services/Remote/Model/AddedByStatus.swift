//
//  File.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
struct AddedByStatus: Codable {
    let yet: Int?
    let owned: Int?
    let beaten: Int?
    let toplay: Int?
    let dropped: Int?
    let playing: Int?

    enum CodingKeys: String, CodingKey {
        case yet
        case owned
        case beaten
        case toplay
        case dropped
        case playing
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        yet = try values.decodeIfPresent(Int.self, forKey: .yet)
        owned = try values.decodeIfPresent(Int.self, forKey: .owned)
        beaten = try values.decodeIfPresent(Int.self, forKey: .beaten)
        toplay = try values.decodeIfPresent(Int.self, forKey: .toplay)
        dropped = try values.decodeIfPresent(Int.self, forKey: .dropped)
        playing = try values.decodeIfPresent(Int.self, forKey: .playing)
    }

}
