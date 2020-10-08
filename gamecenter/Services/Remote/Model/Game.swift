//
//  GameResponse.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

struct Game: Codable {
    let slug: String?
    let name: String?
    let playtime: Int?
    let platforms: [Platforms]?
    let stores: [Stores]?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Ratings]?
    let ratingsCount: Int?
    let added: Int?
    let addedByStatus: AddedByStatus?
    let metacritic: Int?
    let suggestionsCount: Int?
    let id: Int?
    let score: String?
    let clip: Clip?
    let tags: [Tags]?
    let reviewsCount: Int?
    let shortScreenshots: [ShortScreenshots]?
    let parentPlatforms: [ParentPlatformsResponse]?
    let genres: [GenresResponse]?
    
    enum CodingKeys: String, CodingKey {
        
        case slug = "slug"
        case name = "name"
        case playtime = "playtime"
        case platforms = "platforms"
        case stores = "stores"
        case released = "released"
        case tba = "tba"
        case backgroundImage = "background_image"
        case rating = "rating"
        case ratingTop = "rating_top"
        case ratings = "ratings"
        case ratingsCount = "ratings_count"
        case added = "added"
        case addedByStatus = "added_by_status"
        case metacritic = "metacritic"
        case suggestionsCount = "suggestions_count"
        case id = "id"
        case score = "score"
        case clip = "clip"
        case tags = "tags"
        case reviewsCount = "reviews_count"
        case shortScreenshots = "short_screenshots"
        case parentPlatforms = "parent_platforms"
        case genres = "genres"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        playtime = try values.decodeIfPresent(Int.self, forKey: .playtime)
        platforms = try values.decodeIfPresent([Platforms].self, forKey: .platforms)
        stores = try values.decodeIfPresent([Stores].self, forKey: .stores)
        released = try values.decodeIfPresent(String.self, forKey: .released)
        tba = try values.decodeIfPresent(Bool.self, forKey: .tba)
        backgroundImage = try values.decodeIfPresent(String.self, forKey: .backgroundImage)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        ratingTop = try values.decodeIfPresent(Int.self, forKey: .ratingTop)
        ratings = try values.decodeIfPresent([Ratings].self, forKey: .ratings)
        ratingsCount = try values.decodeIfPresent(Int.self, forKey: .ratingsCount)
        added = try values.decodeIfPresent(Int.self, forKey: .added)
        addedByStatus = try values.decodeIfPresent(AddedByStatus.self, forKey: .addedByStatus)
        metacritic = try values.decodeIfPresent(Int.self, forKey: .metacritic)
        suggestionsCount = try values.decodeIfPresent(Int.self, forKey: .suggestionsCount)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        score = try values.decodeIfPresent(String.self, forKey: .score)
        clip = try values.decodeIfPresent(Clip.self, forKey: .clip)
        tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
        reviewsCount = try values.decodeIfPresent(Int.self, forKey: .reviewsCount)
        shortScreenshots = try values.decodeIfPresent([ShortScreenshots].self, forKey: .shortScreenshots)
        parentPlatforms = try values.decodeIfPresent([ParentPlatformsResponse].self, forKey: .parentPlatforms)
        genres = try values.decodeIfPresent([GenresResponse].self, forKey: .genres)
    }
    
}

extension Game {
    func mapToTopGameModel() -> TopVideoGameModel {
        let platform = parentPlatforms?
            .filter { $0.platform != nil}
            .map { $0.platform!.mapToParrentPlatform() }
        
        let detail = genres?
            .filter { $0.name != nil}
            .map { $0.name! }
            .toString(with: ", ")

        return TopVideoGameModel(id: id, name: name,
                                 star: rating, detail: detail,
                                 videoUrl: clip?.clip,
                                 platform: platform,
                                 suggestionCount: suggestionsCount,
                                 store: stores)
    }
}

extension Platform {
    func mapToParrentPlatform() -> ParentPlatformModel {
        return ParentPlatformModel(id: id, name: name)
    }
}

extension Array where Element == String {
    func toString(with divider: String) -> String {
        var result = ""
        for (index, element) in self.enumerated() {
            if index == 0 {
                result += element
            } else {
                result += "\(divider)\(element)"
            }
        }
        return result
    }
}
