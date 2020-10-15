//
//  TopVideoGameRepository.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

protocol TopVideoGameRespositoryType {
    func getGame(isLoadMore: Bool, completion: (([TopVideoGameModel]?, Error?) -> Void)?)
    
    func likeGame(gameModel: TopVideoGameModel)
}

class TopVideoGameRespository: TopVideoGameRespositoryType {
    
    private var favorDB: FavorGameDBType = FavorGameDB()
    
    private let service: APIServiceType = APIService()
    private var currentPage = 1
    private let pageSize = 10
    private var numberOfPageEmptyVideo = 0
    
    func getGame(isLoadMore: Bool, completion: (([TopVideoGameModel]?, Error?) -> Void)?) {
        
        if isLoadMore {
            currentPage += 1
        }
        
        var url = APIService.newGameUrl
        
        let param = APIParam(parrentPlatforms: LocalDB.shared.getFavorPlatform(),
                             genres: LocalDB.shared.getFavorGenre(),
                             page: currentPage, dates: nil,
                             ordering: .relevance,
                             pageSize: pageSize)
        
        if numberOfPageEmptyVideo > 2 {
            currentPage = 0
            numberOfPageEmptyVideo = 0
            url = APIService.baseUrl
        } else {
            url = APIService.newGameUrl
        }
        
        service.loadVideo(url: url, param: param) {[weak self] (games, error) in
            if let games = games?.results, !games.isEmpty {
                var result = games
                    .filter { $0.clip?.clip != nil }
                    .map { $0.mapToTopGameModel() }
                    .shuffled()
                
                //Recall when page have no clip , using recusive
                if result.isEmpty {
                    self?.numberOfPageEmptyVideo += 1
                    self?.getGame(isLoadMore: isLoadMore, completion: completion)
                    return
                }
                
                for (i, element) in result.enumerated() {
                    result[i].isLike = self?.favorDB.isLike(with: element.id) ?? false
                }
                
                completion?(result, nil)
            }
            
            if let error = error {
                completion?(nil, error)
                print(error.localizedDescription)
            }
        }
    }
    
    func likeGame(gameModel: TopVideoGameModel) {
        favorDB.saveFavorGame(game: gameModel)
    }
}
