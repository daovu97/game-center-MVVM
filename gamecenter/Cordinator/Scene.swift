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
    case splash
    case top
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case .top:
            let topVc = UITabBarController()
            
//            let top = TopViewController()
//            top.initViewModel(viewModel: TopViewModel())
//            top.tabBarItem = UITabBarItem(title: "Top", image: UIImage(named: "ic_messenger"), tag: 0)
//            topVc.addChild(top)
            
            let vc = SelectPlatformViewController()
            vc.initViewModel(viewModel: SelectPlatformViewModel())
            return .root(UINavigationController(rootViewController: vc))
        case .splash:
            let splash = SplashViewController()
            return .root(splash)
        }
    }
}
