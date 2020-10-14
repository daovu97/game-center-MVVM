//
//  UIViewController+Extension.swift
//  gamecenter
//
//  Created by daovu on 10/14/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func isVisible() -> Bool {
        return self.isViewLoaded && self.view.window != nil
    }
}
