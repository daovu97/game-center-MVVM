//
//  Scene.swift
//  AutoLayoutEx2
//
//  Created by daovu on 9/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case splash(SplashViewModel)
    case top
    case selectPlatform(SelectPlatformViewModel)
    case selectGenre(SelectGenreViewModel)
    case presentVideo(data: [TopVideoGameModel], position: Int)
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case .top:
            let topVc = TopTabBarViewController()
            return .root(topVc)
        case .splash(let viewModel):
            let splash = SplashViewController()
            splash.initViewModel(viewModel: viewModel)
            return .root(UINavigationController(rootViewController: splash))
        case .selectPlatform(let viewModel):
            let vc = SelectPlatformViewController()
            vc.initViewModel(viewModel: viewModel)
            return .push(vc, withAnim: true)
        case .selectGenre(let viewModel):
            let vc = SelectGenreViewController()
            vc.initViewModel(viewModel: viewModel)
            return .push(vc, withAnim: true)
        case .presentVideo(let data, let position):
            let homeViewController = TopViewController()
            let viewModel = TopViewModel()
            viewModel.setUpPresentData(datas: data, position: position)
            homeViewController.initViewModel(viewModel: viewModel)
            return .present(homeViewController, .fullScreen)
        }
    }
    
}
