//
//  TopViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

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
    
    private lazy var popupView = StoresPopUpView()
    
    private lazy var noIntenetView: UnavailableView = {
        let view = UnavailableView()
        view.image.image = UIImage(named: "ic_no_intenet")
        view.titleLabel.text = noInternetTitle
        view.detailLabel.text = noInternetDetail
        return view
    }()
    
    private var currentItem = IndexPath(row: 0, section: 0)
    
    override func setupView() {
        view.backgroundColor = .black
        setUpCollectionView()
        viewModel.getVideo()
        observeNotification()
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
        super.netWorkStatusChange(isConnected: isConnected)
        if viewModel.datas.isEmpty {
            noIntenetView.isHidden = isConnected
            if isConnected {
                viewModel.getVideo()
            }
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.collectionViewUpdate.bind {[weak self] (update) in
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
                }
            }
            
        }.disposed(by: disposeBag)
    }
    
    override func setupNaviBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
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
        cell.configure(data: viewModel.datas[indexPath.row])
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
        VideoPlayerController.shared.pauseVideosFor(cell: cell)
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return false
    }
    
    func playVideo(at item: IndexPath) {
        if let cell = self.collectionView.cellForItem(at: item) as? TopViewCell {
            cell.hidePause()
            cell.playVideosFor()
        }
    }
    
    func pauseVideo(at item: IndexPath) {
        if let cell = self.collectionView.cellForItem(at: item) as? TopViewCell {
            cell.pauseVideoFor()
        }
    }
}

// MARK: - App lifecycle
extension TopViewController {
    
    private func observeNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.appEnteredFromBackground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterBackgroundNotification(notification:)),
                                               name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc private func appEnteredFromBackground() {
        playVideo(at: currentItem)
    }
    
    @objc private func didEnterBackgroundNotification(notification: NSNotification) {
        pauseVideo(at: currentItem)
    }
}

extension TopViewController: TopViewCellAction {
    func like(model: TopVideoGameModel) {
        print("like + \(model)")
    }
    
    func share(model: TopVideoGameModel) {
        var urlToShare: URL?
        if let url = model.store?.first?.urlEn {
            urlToShare = URL(string: url)
        } else {
            urlToShare = URL(string: model.videoUrl!)
        }
        let someText: String = "\(model.name ?? "Share to")"
        let sharedObjects: [AnyObject] = [urlToShare as AnyObject, someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems: sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop,
                                                         UIActivity.ActivityType.postToFacebook,
                                                         UIActivity.ActivityType.postToTwitter,
                                                         UIActivity.ActivityType.mail,
                                                         UIActivity.ActivityType.message]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func save(model: TopVideoGameModel) {
        showPopup(with: model.store)
    }
}

// MARK: - Popup view
extension TopViewController {
    func showPopup(with value: [StoreModel]?) {
        popupView.show()
        popupView.setupData(data: value)
    }
}
