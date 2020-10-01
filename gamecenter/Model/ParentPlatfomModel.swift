//
//  ParentPlatfomModel.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

struct ParentPlatformModel {
    let id : Int?
    let name : String?
    let slug : String?
    let platforms : [Platform]?
    
    func getIcon() -> UIImage? {
        switch id {
        case 1: return UIImage(named: "ic_plat_window")
        case 2: return UIImage(named: "ic_plat_playstation")
        case 3: return UIImage(named: "ic_plat_xbox")
        case 4: return UIImage(named: "ic_plat_ios")
        case 5: return UIImage(named: "ic_plat_macintosh")
        case 6: return UIImage(named: "ic_plat_linux")
        case 7: return UIImage(named: "ic_plat_intendo")
        case 8: return UIImage(named: "ic_plat_android")
        case 9: return UIImage(named: "ic_plat_atari")
        case 11: return UIImage(named: "ic_lat_sega")
        case 12: return UIImage(named: "ic_plat_3do")
        case 13: return UIImage(named: "ic_plat_neogeo")
        case 14: return UIImage(named: "ic_plat_web")
        default: return UIImage(named: "")
        }
    }
    
    func getBgColor() -> String {
        switch id {
        case 1: return "ic_plat_window"
        case 2: return "ic_plat_playstation"
        case 3: return "ic_plat_xbox"
        case 4: return "ic_plat_ios"
        case 5: return "ic_plat_macintosh"
        case 6: return "ic_plat_linux"
        case 7: return "ic_plat_intendo"
        case 8: return "ic_plat_android"
        case 9: return "ic_plat_atari"
        case 11: return "ic_plat_sega"
        case 12: return "ic_plat_3do"
        case 13: return "ic_plat_neogeo"
        case 14: return "ic_plat_web"
        default: return ""
        }
    }
}
