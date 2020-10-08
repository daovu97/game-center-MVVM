//
//  TopVideoGameModel.swift
//  gamecenter
//
//  Created by daovu on 10/7/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

struct TopVideoGameModel {
    let id: Int?
    let name: String?
    let star: Double?
    let detail: String?
    let videoUrl: String?
    let platform: [ParentPlatformModel]?
    let suggestionCount: Int?
    let store: [Stores]?
}
