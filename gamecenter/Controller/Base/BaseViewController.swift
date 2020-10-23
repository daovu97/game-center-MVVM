//
//  BaseViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import Lottie
import Combine

class BaseViewController<T: BaseViewModel>: UIViewController {
    var subscriptions = Set<AnyCancellable>()
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
    
    private lazy var statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
        setupLoaddingAnimation()
        setupView()
        bindViewModel()
        setupNaviBar()
        setupNoIntenetBanner()
        NetworkManager.shared.networkStatusChange.sink {[weak self] (connected) in
            DispatchQueue.main.async {
                self?.netWorkStatusChange(isConnected: connected)
            }}.store(in: &subscriptions)
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
        viewModel.showProgressStatus.sink {[weak self] (isShow) in
            if isShow {
                self?.loadingAnimation.isHidden = false
                self?.loadingAnimation.play()
            } else {
                self?.loadingAnimation.isHidden = true
                self?.loadingAnimation.stop()
            }
        }.store(in: &subscriptions)
    }
    
    func transparentNavibar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private var noIntenetBannerHeight: CGFloat = 30
    
    private func setupNoIntenetBanner() {
        view.addSubview(noIntenetBannerView)
        noIntenetBannerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil,
                                   trailing: view.trailingAnchor,
                                   padding: .init(top: -noIntenetBannerHeight - statusBarHeight,
                                                  left: 0, bottom: 0, right: 0),
                                   size: .init(width: view.frame.width,
                                               height: noIntenetBannerHeight + statusBarHeight))
    }
    
    func showNoIntenetBanner(shouldShow: Bool = false) {
        self.noIntenetBannerView.isHidden = false
        let transform = shouldShow ?
            CGAffineTransform(translationX: 0,
                              y: noIntenetBannerHeight + statusBarHeight) : .identity
        UIView.animate(withDuration: 0.4, delay: 0,
                       options: .curveEaseOut, animations: {
                        self.noIntenetBannerView.transform = transform
                       }, completion: { _ in
                        self.noIntenetBannerView.isHidden = !shouldShow
                       })
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
    }
    
}

//preview
import SwiftUI

struct ControllerPreview<T: UIViewController>: UIViewControllerRepresentable {
    private var vc: T
    init(vc: UIViewController) {
        if let vc = vc as? T {
            self.vc = vc
        } else {
            self.vc = T.init()
        }
       
    }
    
    func makeUIViewController(context: Context) -> T {
        vc
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) {
        
    }
    
    typealias UIViewControllerType = T
}

struct PreviewView<T: UIViewController>: View {
    private var vc: T
    
    init(vc: UIViewController) {
        if let vc = vc as? T {
            self.vc = vc
        } else {
            self.vc = T.init()
        }
       
    }
    
    var body: some View {
        return ControllerPreview<T>(vc: vc)
    }
}

class PreviewViewController: UIViewController {
   
}

struct CustomPreviewView: View {
    private var view: UIView
    init(view: UIView) {
        self.view = view
    }
    
    var body: some View {
        let vc = PreviewViewController()
        vc.view.addSubview(view)
        view.fillSuperview()
        return ControllerPreview<PreviewViewController>(vc: vc)
    }
}
