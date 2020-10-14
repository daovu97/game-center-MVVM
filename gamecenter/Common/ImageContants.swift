//
//  ImageContants.swift
//  gamecenter
//
//  Created by daovu on 10/14/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

enum Image {
    case unavailableStore
    case close
    case storeSteam
    case game
    case playNormal
    case heart
    case share
    case download
    case play
    case noIntenet
    
    var name: String {
        switch self {
        case .unavailableStore: return "ic_unavailable_store"
        case .close: return "ic_close"
        case .storeSteam: return "ic_store_steam"
        case .game: return "ic_game"
        case .playNormal: return "ic_play_normal"
        case .heart: return "ic_heart"
        case .share: return "ic_share"
        case .download: return "ic_download"
        case .play: return "ic_play"
        case .noIntenet: return "ic_no_intenet"
        }
        
    }
}

enum LottieAnimation {
    case loadding
    case splash
    var name: String {
        switch self {
        case .loadding: return "LoadingAnimation"
        case .splash: return "SplashAnimation"
        }
    }
}
