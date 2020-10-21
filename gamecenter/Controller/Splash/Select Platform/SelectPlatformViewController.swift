//
//  SelectPlatformViewController.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class SelectPlatformViewController: BaseSelectViewController<SelectPlatformViewModel> {
    
    override func setupView() {
        super.setupView()
        setupCollectionView()
        self.viewModel.getPlatforms()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(SellectPlatformCell.self)
        collectionView.registerCell(SelectPlatformHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }
    
    override func bindViewModel() {
        viewModel.collectionViewAupdate.sink {[weak self] (update) in
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
        
        viewModel.didSelectedItem.sink { [weak self] (selected) in
            self?.showFloatingButton(shouldShow: selected)
        }.store(in: &subscriptions)
    }
    
    override func didDoneTaped() {
        viewModel.saveFavorPlatform()
    }
    
}

extension SelectPlatformViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentPlatform = viewModel.platforms[indexPath.row]
        if let size = currentPlatform.type?.icon?.size, let name = currentPlatform.name {
            let ratio = size.width / size.height
            let width = ratio < 1 ? itemHeight : itemHeight * ratio
            
            let labelWidth = calculateFrameInText(message: name, textSize: 20, maxWidth: 200).width + 16 + 8
            
            return .init(width: width + labelWidth, height: itemHeight)
        } else {
            return .init(width: itemHeight, height: itemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let textHeaderSize = calculateFrameInText(message: Titles.selectPlatformHeaderTitle,
                                                  textSize: SelectPlatformHeaderView.titleSize,
                                                  withFont: UIFont.primaryFontNameBold,
                                                  maxWidth: view.frame.width - 34)
        
        let subTextSize = calculateFrameInText(message: Titles.subSelectHeaderTitle,
                                               textSize: SelectPlatformHeaderView.subTitleSize,
                                               withFont: UIFont.primaryFontNameLight,
                                               maxWidth: view.frame.width - 34)
        
        return .init(width: view.frame.width, height: textHeaderSize.height + 8 + subTextSize.height + 24)
    }
}

extension SelectPlatformViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.platforms.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(SellectPlatformCell.self, for: indexPath)
        cell.setupData(platform: viewModel.platforms[indexPath.row],
                       isSelect: viewModel.selectedIndexPath.contains(indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableCell(SelectPlatformHeaderView.self,
                                                        ofKind: UICollectionView.elementKindSectionHeader,
                                                        for: indexPath)
        header.setTitle()
        return header
    }
}

extension SelectPlatformViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        viewModel.setSelectedIndexPath(indexPath: indexPath)
    }
}

func calculateFrameInText(message: String, textSize: CGFloat,
                          withFont font: String = UIFont.primaryFontNameLight,
                          maxWidth: CGFloat) -> CGRect {
    return NSString(string: message)
        .boundingRect(with: CGSize(width: maxWidth, height: 9999999),
                      options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin),
                      attributes: [NSAttributedString.Key.font: UIFont(name: font, size: textSize)!],
                      context: nil)
}
