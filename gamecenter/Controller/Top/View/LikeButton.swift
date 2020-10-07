//
//  LikeButton.swift
//  gamecenter
//
//  Created by daovu on 10/7/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class LikeButton: ImageSubLabelView {
    
    var isLike: Bool = false
    
    override func didTapItem() {
        super.didTapItem()
        isLike = !isLike
        animate(isLike: isLike)
    }
    
    private func animate(isLike: Bool) {
        UIView.animate(withDuration: 0.6) {[weak self] in
            self?.imageView.tintColor = isLike ? UIColor.red : UIColor.white
        }
    }
}
