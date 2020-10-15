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
    case share(sharedObjects: [AnyObject], from: UIViewController)
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
            let repository = TopVideoGameRespository(favorDB: FavorGameDB(), service: APIService())
            let viewModel = TopViewModel(respository: repository)
            viewModel.setUpPresentData(datas: data, position: position)
            homeViewController.initViewModel(viewModel: viewModel)
            return .present(homeViewController, .fullScreen)
        case .share(let sharedObjects, let vc):
            let activityViewController = UIActivityViewController(activityItems: sharedObjects,
                                                                  applicationActivities: nil)
            
            activityViewController.popoverPresentationController?.sourceView = vc.view
            
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop,
                                                             UIActivity.ActivityType.postToFacebook,
                                                             UIActivity.ActivityType.postToTwitter,
                                                             UIActivity.ActivityType.mail,
                                                             UIActivity.ActivityType.message]
            
            return .share(activityViewController, vc)
        }
    }
    
}
