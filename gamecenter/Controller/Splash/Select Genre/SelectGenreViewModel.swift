//
//  SelectGenreViewModel.swift
//  gamecenter
//
//  Created by daovu on 10/2/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import Combine

final class SelectGenreViewModel: BaseSelectViewModel {
    var genres = [GenreModel]()
    private let _collectionViewAupdate = PassthroughSubject<ScrollViewUpdate<GenreModel>, Never>()
    lazy var collectionViewAupdate = _collectionViewAupdate.eraseToAnyPublisher()
    
    func getGenre() {
        let value: BaseResponse<Genre>? = extractJson(from: "SelectGenre")
        genres = (value?.results ?? .init()).map { $0.mapToGenreModel()}
        _collectionViewAupdate.send(.reload)
    }
    
    override func setSelectedIndexPath(indexPath: IndexPath) {
        super.setSelectedIndexPath(indexPath: indexPath)
        _collectionViewAupdate.send(.reload)
    }
    
    func saveFavorGenre() {
        var genres = [GenreModel]()
        selectedIndexPath.forEach { genres.append(self.genres[$0.row]) }
        getLocalDB().saveGenre(genres: genres)
    }
}
