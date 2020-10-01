//
//  SelectPlatformViewController.swift
//  gamecenter
//
//  Created by daovu on 10/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SelectPlatformViewController: BaseViewController<SelectPlatformViewModel> {
    
    private let disposeBag = DisposeBag()
    private let itemHeight = CGFloat(70)
    private let rightButton = UIBarButtonItem(title: "skip", style: .plain,
                                              target: self, action: #selector(didRightBarTap))
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LeftAlignedCollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.insetsLayoutMarginsFromSafeArea = true
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? LeftAlignedCollectionViewFlowLayout {
            layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
            layout.scrollDirection = .vertical
        }
        
        return collectionView
    }()
    
    override func setupView() {
        super.setupView()
        setupCollectionView()
        
        DispatchQueue.main.async {
            self.viewModel.getPlatforms()
        }
    }
    
    override func setupNaviBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(SellectPlatformCell.self)
        collectionView.registerCell(SelectPlatformHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }
    
    override func setupConstrain() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    override func bindViewModel() {
        viewModel.collectionViewAupdate.bind {[weak self] (update) in
            switch update {
            case .add((let value, let position)):
                break
            case .reload:
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }.disposed(by: disposeBag)
    }
    
    @objc private func didRightBarTap() {
        
    }
    
}

extension SelectPlatformViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let size = viewModel.platforms[indexPath.row].getIcon()?.size {
            let ratio = size.width / size.height
            let width = ratio < 1 ? itemHeight : itemHeight * ratio
            
            return .init(width: width, height: itemHeight)
        } else {
            return .init(width: itemHeight, height: itemHeight)
        }
    }
    
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

extension SelectPlatformViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.platforms.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(SellectPlatformCell.self, for: indexPath)
        cell.setupData(platform: viewModel.platforms[indexPath.row])
        cell.isSelect = viewModel.selectedIndexPath.contains(indexPath)
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        return cell
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

extension SelectPlatformViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if viewModel.selectedIndexPath.contains(indexPath) {
            viewModel.selectedIndexPath.remove(indexPath)
        } else {
            viewModel.selectedIndexPath.insert(indexPath)
        }
        self.collectionView.reloadData()
    }
}

func calculateFrameInText(message: String, textSize: CGFloat,
                          withFont font: String = "Helvetica Neue",
                          maxWidth: CGFloat) -> CGRect {
    return NSString(string: message)
        .boundingRect(with: CGSize(width: maxWidth, height: 9999999),
                      options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin),
                      attributes: [NSAttributedString.Key.font: UIFont(name: font, size: textSize)!],
                      context: nil)
}
