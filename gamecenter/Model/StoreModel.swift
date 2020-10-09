//
//  StoreModel.swift
//  gamecenter
//
//  Created by daovu on 10/9/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import UIKit

struct StoreModel {
    let id: Int?
    let name: String?
    let domain: String?
    let urlEn: String?
    let urlRu: String?
    
    var icon: UIImage? {
        get {
            switch id {
            case 1:
                return UIImage(named: "ic_store_steam")
            case 2:
                return UIImage(named: "ic_store_window")
            case 3:
                return UIImage(named: "ic_store_playstation")
            case 4:
                return UIImage(named: "ic_store_app_store")
            case 5:
                return UIImage(named: "ic_store_gog")
            case 6:
                return UIImage(named: "ic_store_nintendo")
            case 7:
                return UIImage(named: "ic_store_xbox")
            case 8:
                return UIImage(named: "ic_store_play_store")
            case 9:
                return  UIImage(named: "ic_store_itch")
            case 11:
                return UIImage(named: "ic_store_epic_game")
            default:
                return UIImage(named: "ic_store_xbox")
            }
        }
    }
}
