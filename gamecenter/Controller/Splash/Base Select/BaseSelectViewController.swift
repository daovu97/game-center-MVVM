//
//  BaseSelectViewController.swift
//  gamecenter
//
//  Created by daovu on 10/2/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class BaseSelectViewController<T: BaseSelectViewModel>: BaseViewController<T> {
    
    let itemHeight = CGFloat(40)
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LeftAlignedCollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.insetsLayoutMarginsFromSafeArea = true
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? LeftAlignedCollectionViewFlowLayout {
            layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
            layout.scrollDirection = .vertical
        }
        
        return collectionView
    }()
    
    lazy var floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemPink
        button.setTitle(Titles.nextLabel, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: primaryFontName_medium, size: 24)
        button.addTarget(self, action: #selector(didDoneTap), for: .touchUpInside)
        return button
    }()
    
    private var floatButtonHeight: CGFloat = 50
    
    override func setupView() {
        super.setupView()
        setupFloatingControls()
    }
    
    @objc private func didRightBarTap() {
        viewModel.gotoMain()
    }
    
    private func setupFloatingControls() {
        view.addSubview(floatingButton)
        floatingButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 0, left: 16, bottom: -floatButtonHeight, right: 16),
                              size: .init(width: 0, height: floatButtonHeight))
    }
    
    override func setupNaviBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = ""
        let rightButton = UIBarButtonItem(title: Titles.skipLabel, style: .plain,
        target: self, action: #selector(didRightBarTap))
        navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = .lightGray
    }
    
    override func setupConstrain() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    func showFloatingButton(shouldShow: Bool = false) {
        let transform = shouldShow ?
            CGAffineTransform(translationX: 0, y: -floatButtonHeight - 12 - view.safeAreaInsets.bottom) : .identity
        let bottomInset = !shouldShow ? CGFloat(0) : floatButtonHeight  + 12 + 12
        UIView.animate(withDuration: 0.7, delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut, animations: {
                        self.floatingButton.transform = transform
                        self.collectionView.contentInset = .init(top: 0, left: 0, bottom: bottomInset, right: 0)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationItem.backBarButtonItem?.title = ""
    }
    
    @objc private func didDoneTap() {
        didDoneTaped()
        viewModel.gotoNext()
    }
    
    open func didDoneTaped() {
        // do magic to save data here
    }
}
