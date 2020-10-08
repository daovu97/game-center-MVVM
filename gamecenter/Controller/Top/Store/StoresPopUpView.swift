//
//  File.swift
//  gamecenter
//
//  Created by daovu on 10/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class StoresPopUpView: UIView {
    
    private var store = [Stores]()
    
    // MARK: - UI Components
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleDismiss(sender:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var popUpView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: ScreenSize.Height * 0.25,
                                        width: ScreenSize.Width,
                                        height: ScreenSize.Height * 0.75))
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panGesture)
        
        let rounded = UIBezierPath.init(roundedRect: .init(origin: .zero,
                                                           size: .init(width: ScreenSize.Width,
                                                                       height: ScreenSize.Height * 0.75)),
                                        byRoundingCorners: [.topLeft, .topRight],
                                        cornerRadii: CGSize.init(width: 12.0, height: 12.0))
        let shape = CAShapeLayer.init()
        shape.path = rounded.cgPath
        view.layer.mask = shape
        return view
    }()
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        
        return collectionView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: primaryFontName_medium, size: 18)
        label.text = "Stores"
        return label
    }()
    
    private lazy var dismissBtn: UIButton = {
        let dismissBtn = UIButton(frame: CGRect(x: ScreenSize.Width - 45, y: 15, width: 30, height: 30))
        dismissBtn.setTitle("", for: .normal)
        dismissBtn.setImage(UIImage(named: "ic_close"), for: .normal)
        dismissBtn.tintColor = .white
        dismissBtn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return dismissBtn
    }()
    
    var totalSlidingDistance = CGFloat()
    var panGesture: UIPanGestureRecognizer!
    
    init() {
        super.init(frame: CGRect(x: 0, y: ScreenSize.Height, width: ScreenSize.Width, height: ScreenSize.Height))
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    private func setupTitleView() {
        popUpView.addSubview(titleLabel)
        titleLabel.anchor(top: popUpView.topAnchor,
                          leading: popUpView.leadingAnchor,
                          bottom: dismissBtn.bottomAnchor,
                          trailing: popUpView.trailingAnchor,
                          padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    private func setupPopupView() {
        addSubview(popUpView)
        
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.frame = self.popUpView.bounds
        visualEffectView.alpha = 1.0
        popUpView.addSubview(visualEffectView)
        popUpView.addSubview(dismissBtn)
    }
    
    private func setupView() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(animatePopUpView(sender:)))
        addSubview(backgroundView)
        setupPopupView()
        setupTitleView()
        
        popUpView.addSubview(collectionView)
        collectionView.anchor(top: dismissBtn.bottomAnchor,
                              leading: popUpView.leadingAnchor,
                              bottom: popUpView.bottomAnchor,
                              trailing: popUpView.trailingAnchor,
                              padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = false
        collectionView.registerCell(StoreViewCell.self)
        collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
       
    }
    
    // MARK: - Display Animations
    @objc func show() {
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
                else {
                    return
            }
            sceneDelegate.window?.addSubview(self)
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: {
                self.frame.origin.y = 0
            })
        } else {
            guard let window = UIApplication.shared.delegate?.window else {
                return
            }
            window?.addSubview(self)
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: {
                self.frame.origin.y = 0
            })
        }
    }
    
    func setupData(data: [Stores]?) {
        if let data = data {
            store = data
            collectionView.reloadData()
        } else {
            //handle empty data
        }
        
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.25, delay: 0.0,
                       options: .curveEaseIn,
                       animations: {
                        self.frame.origin.y = ScreenSize.Height},
                       completion: {[weak self]_ in self?.removeFromSuperview()})
    }
    
    @objc func handleDismiss(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self)
        if self.backgroundView.layer.contains(point) {
            dismiss()
        }
    }
    
    @objc func animatePopUpView(sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: popUpView)
        
        switch sender.state {
        case .began, .changed:
            if totalSlidingDistance <= 0 && transition.y < 0 { return }
            if self.frame.origin.y + transition.y >= 0 {
                self.frame.origin.y += transition.y
                sender.setTranslation(.zero, in: popUpView)
                totalSlidingDistance += transition.y
            }
            
        case .ended:
            if sender.velocity(in: popUpView).y > 300 {
                dismiss()
            } else if totalSlidingDistance >= 0 {
                UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut],
                               animations: {
                                self.frame.origin.y -= self.totalSlidingDistance
                                self.layoutIfNeeded()
                }, completion: nil)
            }
            collectionView.isUserInteractionEnabled = true
            totalSlidingDistance = 0
        default:
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut],
                           animations: {
                            self.frame.origin.y -= self.totalSlidingDistance
                            self.layoutIfNeeded()
            }, completion: nil)
            collectionView.isUserInteractionEnabled = true
            totalSlidingDistance = 0
        }
    }
}

extension StoresPopUpView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        gotoStore(with: store[indexPath.row].urlEn)
    }
    
    func gotoStore(with url: String?) {
        if let url = url, let URL = URL(string: url) {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        }
    }
}

extension StoresPopUpView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 16, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}

extension StoresPopUpView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return store.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(StoreViewCell.self, for: indexPath)
        cell.setupData(data: store[indexPath.row])
        return cell
    }
}

extension StoresPopUpView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 && !scrollView.isDragging {
            collectionView.isUserInteractionEnabled = false
        } else {
            collectionView.isUserInteractionEnabled = true
        }
    }
}
