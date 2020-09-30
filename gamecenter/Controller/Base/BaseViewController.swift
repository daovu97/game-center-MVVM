//
//  BaseViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    var viewModel: BaseViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
        setupView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshView()
    }
    
    func initViewModel(viewModel: BaseViewModel) {
        self.viewModel = viewModel
    }
    
    open func setupView() {}
    
    open func setupConstrain() {}
    
    open func bindViewModel() {}
    
    open func refreshView() {}
    
}
