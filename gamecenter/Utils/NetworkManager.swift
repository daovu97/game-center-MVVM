//
//  NetworkManager.swift
//  gamecenter
//
//  Created by daovu on 10/9/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation
import Network
import UIKit
import Combine

class NetworkManager {
    static var shared: NetworkManager!
    private var monitor: NWPathMonitor?
    var networkStatusChange = CurrentValueSubject<Bool, Never>(false)
    var isConnected: Bool = false
    func start() {
        monitorNetwork()
    }
    
    func monitorNetwork() {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = {[weak self] path in
            if path.status == .satisfied {
                self?.networkStatusChange.send(true)
                self?.isConnected = true
            } else {
                self?.networkStatusChange.send(false)
                self?.isConnected = false
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor?.start(queue: queue)
    }
    
    deinit {
        monitor?.cancel()
    }
    
}
