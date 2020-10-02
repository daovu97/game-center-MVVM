//
//  LoginViewModel.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

final class SplashViewModel: BaseViewModel {
    
    func gotoSelectPlatform() {
        SceneCoordinator.shared.transition(to: Scene.selectPlatform(SelectPlatformViewModel()))
    }
}
