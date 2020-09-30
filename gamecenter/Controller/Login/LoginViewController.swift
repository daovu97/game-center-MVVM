//
//  LoginViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController<LoginViewModel> {
    
    private let loginRegisterButton: LoadingButton = {
        let button = LoadingButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Login with Twitch", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .white
    }
    
    override func setupConstrain() {
        view.addSubview(loginRegisterButton)
        let contrain = [
            loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginRegisterButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            loginRegisterButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(contrain)
    }
    
    override func bindViewModel() {
        
    }
    
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255.0, alpha: alpha)
    }
}
