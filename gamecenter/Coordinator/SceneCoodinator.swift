//
//  SceneCoodinator.swift
//  AutoLayoutEx2
//
//  Created by daovu on 9/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import Combine

/**
 Scene coordinator, manage scene navigation and presentation.
 */

class SceneCoordinator: NSObject, SceneCoordinatorType {
    
    static var shared: SceneCoordinator!
    
    fileprivate var window: UIWindow
    fileprivate var currentViewController: UIViewController {
        didSet {
            currentViewController.navigationController?.delegate = self
            currentViewController.tabBarController?.delegate = self
        }
    }
    
    required init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController!
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        var controller = viewController
        if let tabBarController = controller as? UITabBarController {
            guard let selectedViewController = tabBarController.selectedViewController else {
                return tabBarController
            }
            controller = selectedViewController
            
            return actualViewController(for: controller)
        }
        
        if let navigationController = viewController as? UINavigationController {
            controller = navigationController.viewControllers.first!
            
            return actualViewController(for: controller)
        }
        return controller
    }
    
    @discardableResult
    func transition(to scene: TargetScene) -> AnyPublisher<Void, Never> {
        let subject = PassthroughSubject<Void, Never>()
        
        switch scene.transition {
        case let .tabBar(tabBarController):
            guard let selectedViewController = tabBarController.selectedViewController else {
                fatalError("Selected view controller doesn't exists")
            }
            currentViewController = SceneCoordinator.actualViewController(for: selectedViewController)
            window.rootViewController = tabBarController
        case let .root(viewController):
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            window.rootViewController = viewController
            subject.send()
            subject.send(completion: .finished)
        case let .push(viewController, anim):
            guard let navigationController = currentViewController.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            
            navigationController.pushViewController(SceneCoordinator
                                                        .actualViewController(for: viewController), animated: anim)
            subject.send()
            subject.send(completion: .finished)
        case let .present(viewController, style):
            viewController.modalPresentationStyle = style
            currentViewController.present(viewController, animated: true) {
                subject.send()
                subject.send(completion: .finished)
            }
            
        case let .alert(viewController):
            currentViewController.present(viewController, animated: true) {
                subject.send()
                subject.send(completion: .finished)
            }
        case let .share(activityViewController, vc):
            vc.present(activityViewController, animated: true, completion: {
                subject.send()
                subject.send(completion: .finished)
            })
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    @discardableResult
    func pop(animated: Bool) -> AnyPublisher<Void, Never> {
        let subject = PassthroughSubject<Void, Never>()
        
        if let presentingViewController = currentViewController.presentingViewController {
            currentViewController.dismiss(animated: animated) {
      
            }
        } else if let navigationController = currentViewController.navigationController {
      
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(currentViewController)")
            }
            
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
        }
        
        return subject.eraseToAnyPublisher()
    }
}

// MARK: - UINavigationControllerDelegate

extension SceneCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}

// MARK: - UITabBarControllerDelegate

extension SceneCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}
