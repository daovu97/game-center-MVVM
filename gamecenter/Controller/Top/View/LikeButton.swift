//
//  LikeButton.swift
//  gamecenter
//
//  Created by daovu on 10/7/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class LikeButton: ImageSubLabelView {
    
    var isLike: Bool = false {
        didSet {
            animate(isLike: isLike)
        }
    }
    
    private lazy var fakeLikeButton: UIImageView = {
        let imge = UIImageView(image: UIImage(named: "ic_heart"))
        imge.tintColor = .red
        return imge
    }()
    
    override func didTapItem() {
        super.didTapItem()
        isLike = !isLike
    }
    
    private func animate(isLike: Bool) {
        UIView.animate(withDuration: 0.18, delay: 0.0, options: .curveEaseIn, animations: {// HERE
            self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1.6, y: 1.6) // Scale your imag
            self.imageView.tintColor = isLike ? UIColor.systemPink : UIColor.white
        }, completion: { _ in
            UIView.animate(withDuration: 0.15, animations: {
                self.imageView.transform = CGAffineTransform.identity // undo in 1 seconds
            })
        })
    }
}
