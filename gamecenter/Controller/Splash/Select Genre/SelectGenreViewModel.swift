//
//  SelectGenreViewModel.swift
//  gamecenter
//
//  Created by daovu on 10/2/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RxSwift

final class SelectGenreViewModel: BaseSelectViewModel {
    var genres = [GenreModel]()
    var collectionViewAupdate = PublishSubject<ScrollViewUpdate<ParentPlatformModel>>()
    
    func getGenre() {
        let value: BaseResponse<Genre>? = extractJson(from: "SelectGenre")
        genres = (value?.results ?? .init()).map { $0.mapToGenreModel()}
        collectionViewAupdate.onNext(.reload)
    }
    
    override func setSelectedIndexPath(indexPath: IndexPath) {
        super.setSelectedIndexPath(indexPath: indexPath)
        collectionViewAupdate.onNext(.reload)
    }
}
