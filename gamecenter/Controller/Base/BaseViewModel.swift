//
//  BaseViewModel.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import Combine

open class BaseViewModel {
    
    var showProgressStatus = PassthroughSubject<Bool, Never>()
    
    func showProgress() {
        showProgressStatus.send(true)
    }
    
    func hideProgress() {
        showProgressStatus.send(false)
    }
    
    func isConnectedToNetwork() -> Bool {
        return NetworkManager.shared.isConnected
    }
    
}
