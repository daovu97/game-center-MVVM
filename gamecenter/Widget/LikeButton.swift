//
//  LikeButton.swift
//  gamecenter
//
//  Created by daovu on 10/7/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class LikeButton: ImageSubLabelView {
    
    private(set) var isLike: Bool = false
    
    private lazy var fakeLikeButton: UIImageView = {
        let imge = UIImageView(image: UIImage(named: Image.heart.name))
        imge.tintColor = .red
        return imge
    }()
    
    override func didTapItem() {
        super.didTapItem()
        setLike(isLike: !isLike)
    }
    
    func setLike(isLike: Bool, withAnime: Bool = true) {
        //Change line count
        if let likeCountString = textLabel.text, var count = Int(likeCountString), self.isLike != isLike {
            if isLike {
                count += 1
            } else {
                count -= 1
            }
            
            textLabel.text = "\(count)"
        }
        
        self.isLike = isLike
        if withAnime {
            animate(isLike: isLike)
        } else {
            self.imageView.tintColor = isLike ? UIColor.systemPink : UIColor.white
        }
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
