//
//  TopTabBarViewController.swift
//  gamecenter
//
//  Created by daovu on 10/5/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class TopTabBarViewController: UITabBarController {
    
    var homeViewController: TopViewController!
    //Not have enough time, so remove it
//    var discoverViewController: UIViewController!
    var profileViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .white
        
        view.backgroundColor = .black
        homeViewController = TopViewController()
        homeViewController.initViewModel(viewModel: TopViewModel())
        
//        discoverViewController = UIViewController()
//        discoverViewController.view.backgroundColor = .black
        
        profileViewController = UIViewController()
        profileViewController.view.backgroundColor = .black
        
        homeViewController.tabBarItem.image = UIImage(named: "ic_tab_home_normal")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "ic_tab_home_selected")
        homeViewController.tabBarItem.title = "Home"
        
//        discoverViewController.tabBarItem.image = UIImage(named: "ic_tab_discovery_selected")
//        discoverViewController.tabBarItem.selectedImage = UIImage(named: "ic_tab_discovery_selected")
//        discoverViewController.tabBarItem.title = "Discover"
        
        profileViewController.tabBarItem.image = UIImage(named: "ic_tab_profile_selected")
        profileViewController.tabBarItem.selectedImage = UIImage(named: "ic_tab_profile_selected")
        profileViewController.tabBarItem.title = "Me"
        
        viewControllers = [
         UINavigationController(rootViewController: homeViewController),
//         UINavigationController(rootViewController: discoverViewController),
         UINavigationController(rootViewController: profileViewController)
        ]
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
