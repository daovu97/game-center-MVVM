//
//  LoginViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: BaseViewController<SplashViewModel> {
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didNextTap), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemPink
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: primaryFontName_medium, size: 24)
        return button
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = splashHeaderTitle
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont(name: primaryFontName_light, size: 16)
        return label
    }()
    
    private lazy var animationBackground: AnimationView = {
        let animationView = AnimationView(name: "SplashAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.2
        animationView.loopMode = .loop
        return animationView
    }()
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .white
    }
    
    override func setupConstrain() {
        view.addSubview(animationBackground)
        animationBackground.fillSuperview()
        setupNextButton()
        setupTextLable()
    }
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.anchor(top: nil,
                          leading: view.leadingAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    private func setupTextLable() {
        view.addSubview(textLabel)
        textLabel.anchor(top: nil,
                         leading: view.leadingAnchor,
                         bottom: nextButton.topAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 16, bottom: 8, right: 16))
    }
    
    override func bindViewModel() {
        
    }
    
    override func setupNaviBar() {
        navigationItem.title = ""
    }
    
    @objc private func didNextTap() {
        viewModel.gotoSelectPlatform()
    }
    
    override func refreshView() {
        super.refreshView()
        navigationController?.setNavigationBarHidden(true, animated: true)
        animationBackground.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        animationBackground.stop()
    }
    
}
