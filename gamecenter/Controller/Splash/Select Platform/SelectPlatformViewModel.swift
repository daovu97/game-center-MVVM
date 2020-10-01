//
//  SelectPlatformViewModel.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import RxSwift

final class SelectPlatformViewModel: BaseViewModel {
    
    var platforms = [ParentPlatformModel]()
    var collectionViewAupdate = PublishSubject<ScrollViewUpdate<ParentPlatformModel>>()
    
    func getPlatforms() {
        platforms.append(contentsOf: [
            ParentPlatformModel(id: 1, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 2, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 3, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 4, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 5, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 6, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 7, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 8, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 9, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 11, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 12, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 13, name: "", slug: "", platforms: nil),
            ParentPlatformModel(id: 14, name: "", slug: "", platforms: nil),
        ])
        collectionViewAupdate.onNext(.reload)
    }
    
}

enum ScrollViewUpdate<T> {
    case add((value: [T], position: [Int]))
    case reload
}
