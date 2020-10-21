//
//  ProfileViewController.swift
//  gamecenter
//
//  Created by daovu on 10/12/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        }
        
        collectionView.insetsLayoutMarginsFromSafeArea = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.registerCell(ProfileFavorCell.self)
        collectionView.registerCell(NoFavorVideoCell.self)
        collectionView.registerCell(ProfileheaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()
    
    override func setupView() {
        view.backgroundColor = .white
        setupCollectionview()
    }
    
    private func setupCollectionview() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.collectionViewUpdate.sink {[weak self] (update) in
            switch update {
            case .add:
                break
            case .reload:
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .scrollTo: break
            case .reloadAt: break
            }
        }.store(in: &subscriptions)
    }
    
    override func setupNaviBar() {
        transparentNavibar()
        navigationItem.title = ""
    }
    
    override func refreshView() {
        super.refreshView()
        viewModel.getFavorVideo()
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !viewModel.data.isEmpty {
            let size = (collectionView.frame.width - 16) / 3 - 8
            return .init(width: size, height: size)
        } else {
            return .init(width: collectionView.frame.width, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerheight = collectionView.frame.height * 0.4
        return .init(width: collectionView.frame.width, height: headerheight)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.isEmpty ? 1 : viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.data.isEmpty {
            let cell = collectionView.dequeueReusableCell(NoFavorVideoCell.self, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(ProfileFavorCell.self, for: indexPath)
            cell.setUpData(data: viewModel.data[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableCell(ProfileheaderView.self,
                                                        ofKind: UICollectionView.elementKindSectionHeader,
                                                        for: indexPath)
        return header
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        viewModel.presentVideo(at: indexPath)
    }
}
