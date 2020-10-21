//
//  BaseViewModel.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

open class BaseViewModel {
    
//    var showProgressStatus = PublishSubject<Bool>()
    
    func showProgress() {
//        showProgressStatus.onNext(true)
    }
    
    func hideProgress() {
//        showProgressStatus.onNext(false)
    }
    
    func isConnectedToNetwork() -> Bool {
        return NetworkManager.shared.isConnected
    }
    
}
