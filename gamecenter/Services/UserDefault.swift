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
    
    func isFirstLaunch() -> Bool {
        UserDefaults.standard.bool(forKey: isFirstLaunchKey) != true
    }
    
    func setFirstLaunch(isFirstLaunch: Bool) {
        UserDefaults.standard.set(isFirstLaunch, forKey: isFirstLaunchKey)
    }
}
