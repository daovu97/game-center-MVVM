//
//  SceneTransitionType.swift
//  AutoLayoutEx2
//
//  Created by daovu on 9/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import Combine

enum SceneTransitionType {
    // you can extend this to add animated transition types,
    // interactive transitions and even child view controllers!
    
    case root(UIViewController)       // make view controller the root view controller.
    case push(UIViewController, withAnim: Bool) // push view controller to navigation stack.
    case present(UIViewController,
        _ style: UIModalPresentationStyle = UIModalPresentationStyle.formSheet)    // present view controller.
    case alert(UIViewController)      // present alert.
    case tabBar(UITabBarController)   // make tab bar controller the root controller.
    case share(UIActivityViewController, UIViewController)
}

protocol SceneCoordinatorType {
    init(window: UIWindow)
    
    @discardableResult func transition(to scene: TargetScene) -> AnyPublisher<Void, Never>
    @discardableResult func pop(animated: Bool) -> AnyPublisher<Void, Never>
}
