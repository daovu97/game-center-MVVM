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
    
    internal lazy var collectionView: UICollectionView = {
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
    
    override func setupView() {
        view.backgroundColor = .black
        setUpCollectionView()
        viewModel.getVideo()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.appEnteredFromBackground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appEnteredFromBackground() {
//        viewModel.setUpVideoData()
        playVideo(at: currentItem)
    }
    
    override func refreshView() {
        super.refreshView()
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
    }
    
    override func bindViewModel() {
        viewModel.collectionViewUpdate.bind { (update) in
            switch update {
            case .add: break
            case .reload:
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }.disposed(by: disposeBag)
    }
    
    override func setupNaviBar() {
        //         navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playVideo(at: currentItem)
    }
    
    private(set) var currentItem = IndexPath(row: 0, section: 0)
}

extension TopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(TopViewCell.self, for: indexPath)
        cell.configure(url: viewModel.videos[indexPath.row])
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          print("willDisplay")
        currentItem = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("didEndDisplaying")
        VideoPlayerController.shared.pauseVideosFor(cell: cell)
    }
    
    func playVideo(at item: IndexPath) {
        if let cell = self.collectionView.cellForItem(at: item) {
            VideoPlayerController.shared.playVideosFor(cell: cell)
        }
    }
}
