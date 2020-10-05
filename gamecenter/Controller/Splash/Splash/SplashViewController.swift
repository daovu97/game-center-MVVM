//
//  LoginViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController<SplashViewModel> {
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(didNextTap), for: .touchUpInside)
        return button
    }()
    
    override func setupView() {
        super.setupView()
    }
    
    override func setupConstrain() {
        view.addSubview(nextButton)
        nextButton.centerInSuperview(size: .init(width: 200, height: 50))
    }
    
    override func bindViewModel() {
        
    }
    
    @objc private func didNextTap() {
        viewModel.gotoSelectPlatform()
    }
    
}
