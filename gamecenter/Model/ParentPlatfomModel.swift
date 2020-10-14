//
//  ParentPlatfomModel.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

struct ParentPlatformModel {
    let id: Int?
    let name: String?
    var type: PlatformType? {
        return PlatformType.init(rawValue: id ?? PlatformType.window.rawValue)
    }
}

enum PlatformType: Int {
    case window = 1
    case playStation = 2
    case xbox = 3
    case ios = 4
    case macintosh = 5
    case linux = 6
    case nintendo = 7
    case android = 8
    case atari = 9
    case sega = 11
    case g3do = 12
    case neogeo = 13
    case web = 14
    
    var icon: UIImage? {
        switch self {
        case .window:
            return UIImage(named: "ic_plat_window")
        case .playStation:
            return UIImage(named: "ic_plat_playstation")
        case .xbox:
            return UIImage(named: "ic_plat_xbox")
        case .ios:
            return UIImage(named: "ic_plat_ios")
        case .macintosh:
            return UIImage(named: "ic_plat_macintosh")
        case .linux:
            return UIImage(named: "ic_plat_linux")
        case .nintendo:
            return UIImage(named: "ic_plat_intendo")
        case .android:
            return UIImage(named: "ic_plat_android")
        case .atari:
            return UIImage(named: "ic_plat_atari")
        case .sega:
            return UIImage(named: "ic_lat_sega")
        case .g3do:
            return UIImage(named: "ic_plat_3do")
        case .neogeo:
            return UIImage(named: "ic_plat_neogeo")
        case .web:
            return UIImage(named: "ic_plat_web")
        }
    }
}
