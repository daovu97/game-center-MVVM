//
//  AppDelegate.swift
//  gamecenter
//
//  Created by daovu on 9/29/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkManager.shared = NetworkManager()
        NetworkManager.shared.start()
        
        window = UIWindow()
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        let sceneCoordinator = SceneCoordinator(window: window!)
        SceneCoordinator.shared = sceneCoordinator
        LocalDB.shared = LocalDB()
        
        if LocalDB.shared.isFirstLaunch() {
            sceneCoordinator.transition(to: Scene.splash(SplashViewModel()))
              LocalDB.shared.setFirstLaunch(isFirstLaunch: true)
        } else {
            sceneCoordinator.transition(to: Scene.top)
        }
        
        return true
    }
}
