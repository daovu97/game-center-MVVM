//
//  SelectGenreViewController.swift
//  gamecenter
//
//  Created by daovu on 10/2/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SelectGenreViewController: BaseSelectViewController<SelectGenreViewModel> {
  
    override func setupView() {
        super.setupView()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.registerCell(SellectPlatformCell.self)
//        collectionView.registerCell(SelectPlatformHeaderView.self,
//                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }
    
    override func bindViewModel() {
        viewModel.collectionViewAupdate.bind {[weak self] (update) in
            switch update {
            case .add:
                break
            case .reload:
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }.disposed(by: disposeBag)

        viewModel.didSelectedItem.bind {[weak self] (selected) in
            self?.showFloatingButton(shouldShow: selected)
        }.disposed(by: disposeBag)
    }
}

extension SelectGenreViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if let size = viewModel.platforms[indexPath.row].getIcon()?.size {
//            let ratio = size.width / size.height
//            let width = ratio < 1 ? itemHeight : itemHeight * ratio
//
//            return .init(width: width, height: itemHeight)
//        } else {
//            return .init(width: itemHeight, height: itemHeight)
//        }
//    }
//
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let textHeaderSize = calculateFrameInText(message: selectPlatformHeaderTitle,
                                                  textSize: 40,
                                                  withFont: "Helvetica Neue",
                                                  maxWidth: view.frame.width - 24)
        
        return .init(width: view.frame.width, height: textHeaderSize.height + 24)
    }
}

extension SelectGenreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(SellectPlatformCell.self, for: indexPath)
//        cell.setupData(platform: viewModel.platforms[indexPath.row])
//        cell.isSelect = viewModel.selectedIndexPath.contains(indexPath)
//
//        cell.layer.shadowColor = UIColor.lightGray.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        cell.layer.shadowRadius = 2.0
//        cell.layer.shadowOpacity = 1.0
//        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds,
//                                             cornerRadius: cell.contentView.layer.cornerRadius).cgPath
//        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableCell(SelectPlatformHeaderView.self,
                                                        ofKind: UICollectionView.elementKindSectionHeader,
                                                        for: indexPath)
        return header
    }
}

extension SelectGenreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
//        viewModel.setSelectedIndexPath(indexPath: indexPath)
    }
}
