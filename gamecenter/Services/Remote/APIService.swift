//
//  APIService.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

struct APIParam {
    var parrentPlatforms: String?
    var genres: String?
    var page: Int
    var dates: String?
    var ordering: OrderingType?
    var discover: Bool = true
    var pageSize: Int = 10
    
    enum OrderingType: String {
        case relevance = "-relevance"
        case name
        case released
        case added
        case created
        case rating
        case name_dsc = "-name"
        case released_dsc = "-released"
        case added_dsc = "-added"
        case created_dsc = "-created"
        case rating_dsc = "-rating"
    }
    
    func getParam() -> [String: Any] {
        var parram = [String: Any]()
        if let parrentPlatforms = parrentPlatforms, !parrentPlatforms.isEmpty {
            parram["parrent_platforms"] = parrentPlatforms
        }
        
        if let dates = dates, !dates.isEmpty {
            parram["dates"] = dates
        }
        
        if let ordering = ordering?.rawValue {
            parram["ordering"] = ordering
        }
        
        if let genres = genres, !genres.isEmpty {
            parram["genres"] = genres
        }
        
        parram["page_size"] = pageSize
        parram["page"] = page
        
        return parram
    }
}

enum APIURL: CaseIterable {
    case base
    case new
    
    var url: String {
        switch self {
        case .base:
            return "https://api.rawg.io/api/games"
        case .new:
            return "https://api.rawg.io/api/games/lists/main"
        }
    }
}

protocol APIServiceType {
    func loadVideo(url: String, param: APIParam, completion: ((BaseResponse<Game>?, Error?) -> Void)?)
}

struct APIService: APIServiceType {
    
    func loadVideo(url: String, param: APIParam, completion: ((BaseResponse<Game>?, Error?) -> Void)?) {
        AF.request(url, method: .get, parameters: param.getParam())
            .validate()
            .responseDecodable(of: BaseResponse<Game>.self) { (response) in
                guard let data = response.value  else {
                    completion?(nil, response.error)
                    return
                }
                completion?(data, nil)
            }
    }
}
