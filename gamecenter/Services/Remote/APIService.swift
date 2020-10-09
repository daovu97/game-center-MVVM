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
        return ["parrent_platforms": parrentPlatforms, "dates": dates, "page": page,
                "ordering": ordering?.rawValue, "page_size": pageSize]
    }
}

protocol APIServiceType {
    func loadVideo(param: APIParam, completion: (([Game]?, Error?) -> Void)?)
}

struct APIService: APIServiceType {
    static let baseUrl = "https://api.rawg.io/api/games"
    
    func loadVideo(param: APIParam, completion: (([Game]?, Error?) -> Void)?) {
        AF.request(APIService.baseUrl, method: .get, parameters: param.getParam())
            .validate()
            .responseDecodable(of: BaseResponse<Game>.self) { (response) in
                guard let data = response.value?.results  else {
                    completion?(nil, response.error)
                    return
                }
                completion?(data.filter { $0.clip?.clip != nil }, nil)
        }
    }
}
