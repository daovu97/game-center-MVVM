//
//  LoginViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController<SplashViewModel> {

    override func setupView() {
        super.setupView()
        view.backgroundColor = .white
    }
    
    override func setupConstrain() {
      
    }
    
    override func bindViewModel() {
        
    }
    
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255.0, alpha: alpha)
    }
}
