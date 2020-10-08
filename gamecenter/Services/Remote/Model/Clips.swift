//
//  File.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
struct Clips: Codable {
    let video320: String?
    let video640: String?
    let full: String?

    enum CodingKeys: String, CodingKey {
        case video320 = "320"
        case video640 = "640"
        case full = "full"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        video320 = try values.decodeIfPresent(String.self, forKey: .video320)
        video640 = try values.decodeIfPresent(String.self, forKey: .video640)
        full = try values.decodeIfPresent(String.self, forKey: .full)
    }

}

struct Clip: Codable {
    let clip: String?
    let clips: Clips?
    let video: String?
    let preview: String?

    enum CodingKeys: String, CodingKey {
        case clip
        case clips
        case video
        case preview
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        clip = try values.decodeIfPresent(String.self, forKey: .clip)
        clips = try values.decodeIfPresent(Clips.self, forKey: .clips)
        video = try values.decodeIfPresent(String.self, forKey: .video)
        preview = try values.decodeIfPresent(String.self, forKey: .preview)
    }

}
