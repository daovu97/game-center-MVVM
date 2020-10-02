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
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case .top:
            let topVc = UITabBarController()
            let top = TopViewController()
            top.initViewModel(viewModel: TopViewModel())
            top.tabBarItem = UITabBarItem(title: "Top", image: UIImage(named: "ic_messenger"), tag: 0)
            topVc.addChild(top)
            return .root(UINavigationController(rootViewController: topVc))
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
        }
    }
    
}
