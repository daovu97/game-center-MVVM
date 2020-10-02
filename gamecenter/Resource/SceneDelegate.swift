//
//  SceneDelegate.swift
//  gamecenter
//
//  Created by daovu on 9/29/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        let sceneCoordinator = SceneCoordinator(window: window!)
        SceneCoordinator.shared = sceneCoordinator
        LocalDB.shared = LocalDB()
        
        if LocalDB.shared.isFirstLaunch() {
            sceneCoordinator.transition(to: Scene.splash(SplashViewModel()))
            //  LocalDB.shared.setFirstLaunch(isFirstLaunch: true)
        } else {
            sceneCoordinator.transition(to: Scene.top)
        }
    }
}
