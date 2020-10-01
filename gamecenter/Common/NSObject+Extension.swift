//
//  NSObject+Extension.swift
//  AutoLayoutEx2
//
//  Created by daovu on 9/1/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

protocol NameDescribable {
    var className: String { get }
    static var className: String { get }
}

extension NameDescribable {
    var className: String {
        return String(describing: type(of: self))
    }

    static var className: String {
        return String(describing: self)
    }
}

extension NSObject: NameDescribable {}
extension Array: NameDescribable {}
