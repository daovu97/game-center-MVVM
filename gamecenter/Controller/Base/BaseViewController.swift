//
//  BaseViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

class BaseViewController<T: BaseViewModel>: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: T!
    
    private lazy var loadingAnimation: AnimationView = {
        let animationView = AnimationView(name: "LoadingAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.8
        animationView.loopMode = .loop
        self.view.addSubview(animationView)
        self.view.bringSubviewToFront(animationView)
        animationView.isHidden = true
        animationView.centerInSuperview(size: .init(width: 100, height: 100))
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
        setupLoaddingAnimation()
        setupView()
        bindViewModel()
        setupNaviBar()
        
        NetworkManager.shared.networkStatusChange.bind {[weak self] (connected) in
            DispatchQueue.main.async {
                 self?.netWorkStatusChange(isConnected: connected)
            }
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshView()
    }
    
    func initViewModel(viewModel: BaseViewModel) {
        if viewModel is T {
            self.viewModel = viewModel as? T
        } 
        
    }
    
    open func setupView() {
        view.backgroundColor = .black
    }
    
    open func setupConstrain() {}
    
    open func bindViewModel() {}
    
    open func refreshView() {}
    
    open func setupNaviBar() {}
    
    @objc open func netWorkStatusChange(isConnected: Bool) {}
    
    private func setupLoaddingAnimation() {
        viewModel.showProgressStatus.bind {[weak self] (isShow) in
            if isShow {
                self?.loadingAnimation.isHidden = false
                self?.loadingAnimation.play()
            } else {
                self?.loadingAnimation.isHidden = true
                self?.loadingAnimation.stop()
            }
        }.disposed(by: disposeBag)
    }
    
    func transparentNavibar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
}
