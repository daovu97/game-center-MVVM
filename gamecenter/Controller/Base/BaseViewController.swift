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
        let animationView = AnimationView(name: LottieAnimation.loadding.name)
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
    
    private lazy var noIntenetBannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.anchor(top: nil, leading: view.leadingAnchor,
                     bottom: view.bottomAnchor,
                     trailing: view.trailingAnchor,
                     padding: .init(top: 0, left: 0, bottom: 6, right: 0))
        label.text = Titles.noInternetConnection
        label.textAlignment = .center
        label.textColor = .white
        view.isHidden = true
        self.view.bringSubviewToFront(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
        setupLoaddingAnimation()
        setupView()
        bindViewModel()
        setupNaviBar()
        setupNoIntenetBanner()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self is SplashViewController || self is SelectGenreViewController ||
            self is SelectPlatformViewController {
            navigationController?.navigationBar.barStyle = .default
        } else {
            navigationController?.navigationBar.barStyle = .black
        }
        
    }
    
    open func setupConstrain() {}
    
    open func bindViewModel() {}
    
    open func refreshView() {}
    
    open func setupNaviBar() {}
    
    @objc open func netWorkStatusChange(isConnected: Bool) {
        guard !(self is SplashViewController) else { return }
        showNoIntenetBanner(shouldShow: !isConnected)
    }
    
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
    
    private var noIntenetBannerHeight: CGFloat = 30
    
    private func setupNoIntenetBanner() {
        view.addSubview(noIntenetBannerView)
        let statusBarheight = UIApplication.shared.statusBarFrame.height
        noIntenetBannerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil,
                                   trailing: view.trailingAnchor,
                                   padding: .init(top: -noIntenetBannerHeight - statusBarheight,
                                                  left: 0, bottom: 0, right: 0),
                                   size: .init(width: view.frame.width,
                                               height: noIntenetBannerHeight + statusBarheight))
    }
    
    func showNoIntenetBanner(shouldShow: Bool = false) {
        self.noIntenetBannerView.isHidden = false
        let transform = shouldShow ?
            CGAffineTransform(translationX: 0,
                              y: noIntenetBannerHeight + UIApplication.shared.statusBarFrame.height) : .identity
        UIView.animate(withDuration: 0.4, delay: 0,
                       options: .curveEaseOut, animations: {
                        self.noIntenetBannerView.transform = transform
        }, completion: { _ in
            self.noIntenetBannerView.isHidden = !shouldShow
        })
    }
    
}
