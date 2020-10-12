//
//  UserDefault.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

class LocalDB {
    
    static var shared: LocalDB!
    
    private let isFirstLaunchKey = "IsFirstLaunchKey"
    private let favorPlatform = "FavorPlatform"
    private let favorGenre = "FavorGenre"
    
    func isFirstLaunch() -> Bool {
        UserDefaults.standard.bool(forKey: isFirstLaunchKey) != true
    }
    
    func setFirstLaunch(isFirstLaunch: Bool) {
        UserDefaults.standard.set(isFirstLaunch, forKey: isFirstLaunchKey)
    }
    
    func savePlatform(platforms: [ParentPlatformModel]) {
        let platform = platforms
            .filter { $0.id != nil }
            .map { "\($0.id!)" }
            .toString(with: ",")
        UserDefaults.standard.set(platform, forKey: favorPlatform)
    }
    
    func getFavorPlatform() -> String {
        UserDefaults.standard.string(forKey: favorPlatform) ?? ""
    }
    
    func saveGenre(genres: [GenreModel]) {
        let genres = genres
            .filter { $0.id != nil }
            .map { "\($0.id!)" }
            .toString(with: ",")
        UserDefaults.standard.set(genres, forKey: favorGenre)
    }
    
    func getFavorGenre() -> String {
        UserDefaults.standard.string(forKey: favorGenre) ?? ""
    }
}
