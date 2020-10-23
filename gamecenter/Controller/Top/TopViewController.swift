//
//  TopViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import SwiftUI

class TopViewController: BaseViewController<TopViewModel> {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.alwaysBounceVertical = false
        collectionView.insetsLayoutMarginsFromSafeArea = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .vertical
        }
        
        return collectionView
    }()
    
    private lazy var closeButton: UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named: Image.close.name)
        button.tintColor = .white
        return button
    }()
    
    private lazy var popupView = StoresPopUpView()
    
    private lazy var noIntenetView: UnavailableView = {
        let view = UnavailableView()
        view.image.image = UIImage(named: Image.noIntenet.name)
        view.titleLabel.text = Titles.noInternetTitle
        view.detailLabel.text = Titles.noInternetDetail
        return view
    }()
    
    private var currentItem = IndexPath(row: 0, section: 0)
    
    override func setupView() {
        view.backgroundColor = .black
        setUpCollectionView()
        viewModel.getVideo()
        observeNotification()
        viewModel.addNotificationWhenLikeChange()
    }
    
    override func refreshView() {
        super.refreshView()
        self.playVideo(at: self.currentItem)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pauseVideo(at: currentItem)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(TopViewCell.self)
    }
    
    override func setupConstrain() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.trailingAnchor)
        view.addSubview(noIntenetView)
        noIntenetView.fillSuperview()
    }
    
    override func netWorkStatusChange(isConnected: Bool) {
        viewModel.networkSatuschange(isConnected: isConnected)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.collectionViewUpdate.sink {[weak self] (update) in
            DispatchQueue.main.async {
                switch update {
                case .add(_, let position):
                    self?.collectionView.performBatchUpdates({
                        self?.collectionView.insertItems(at: position)
                    }, completion: nil)
                case .reload:
                    self?.collectionView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.playVideo(at: self?.currentItem ?? IndexPath())
                    }
                case .scrollTo:
                    break
                case .reloadAt(let position):
                    DispatchQueue.main.async {
                        self?.collectionView.reloadItems(at: position)
                    }
                }
            }
            
        }.store(in: &subscriptions)
        
        viewModel.isPresentMode.sink {[weak self] (show, position) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                if show {
                    self?.setUpBackButton()
                    self?.collectionView.scrollToItem(at: position, at: .top, animated: false)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.playVideo(at: self?.currentItem ?? IndexPath())
                    }
                } else {
                    self?.closeButton.removeFromSuperview()
                }
            }
        }.store(in: &subscriptions)
        
        viewModel.noIntenetViewShow.sink {[weak self] (isShow) in
            self?.noIntenetView.isHidden = !isShow
        }.store(in: &subscriptions)
        
        viewModel.noIntenetbannerViewShow.sink {[weak self] (isShow) in
            self?.showNoIntenetBanner(shouldShow: isShow)
        }.store(in: &subscriptions)
    }
    
    private func setUpBackButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: nil,
                          bottom: nil, trailing: view.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 8),
                          size: .init(width: 30, height: 30))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didBackTapped)))
    }
    
    @objc private func didBackTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func setupNaviBar() {
        transparentNavibar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension TopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(TopViewCell.self, for: indexPath)
        cell.configure(data: viewModel.datas[indexPath.row], position: indexPath.row)
        cell.action = self
        return cell
    }
}

extension TopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension TopViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        playVideo(at: currentItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        currentItem = indexPath
        if currentItem.row == viewModel.datas.count - 2 {
            viewModel.getVideo(isLoadmore: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? TopViewCell {
            cell.pause()
        }
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return false
    }
    
    func playVideo(at item: IndexPath) {
        if let cell = self.collectionView.cellForItem(at: item) as? TopViewCell {
            cell.replay()
        }
    }
    
    func pauseVideo(at item: IndexPath) {
        if let cell = self.collectionView.cellForItem(at: item) as? TopViewCell {
            cell.pause()
        }
    }
}

// MARK: - App lifecycle
extension TopViewController {
    
    private func observeNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.appEnteredFromBackground),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterBackgroundNotification(notification:)),
                                               name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc private func appEnteredFromBackground() {
        if isVisible() {
            playVideo(at: currentItem)
        }
    }
    
    @objc private func didEnterBackgroundNotification(notification: NSNotification) {
        pauseVideo(at: currentItem)
    }
}

extension TopViewController: TopViewCellAction {
    func like(isLike: Bool, position: Int) {
        viewModel.likeVideo(isLike: isLike, position: position)
    }
    
    func share(model: TopVideoGameModel) {
        viewModel.share(model: model, vc: self)
    }
    
    func save(model: TopVideoGameModel) {
        showPopup(with: model.store, itemName: model.name)
    }
}

// MARK: - Popup view
extension TopViewController {
    func showPopup(with value: [StoreModel]?, itemName: String?) {
        popupView.show()
        popupView.setupData(data: value, itemName: itemName)
    }
}

struct TopViewController_Previews: PreviewProvider {
    static var previews: some View {
        let vc = TopViewController()
        let respository = TopVideoGameRespository(favorDB: FavorGameDB(), service: APIService())
        vc.initViewModel(viewModel: TopViewModel(respository: respository))
        return PreviewView<TopViewController>(vc: vc)
    }
}
