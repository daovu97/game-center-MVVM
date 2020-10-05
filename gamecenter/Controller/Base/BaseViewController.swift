//
//  BaseViewController.swift
//  gamecenter
//
//  Created by daovu on 9/30/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController<T: BaseViewModel>: UIViewController {
    internal let disposeBag = DisposeBag()
    var viewModel: T!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
        setupView()
        bindViewModel()
        setupNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshView()
    }
    
    func initViewModel(viewModel: BaseViewModel) {
        if viewModel is T {
            self.viewModel = viewModel as? T
        } 
        
    }
    
    open func setupView() {
        view.backgroundColor = .black
    }
    
    open func setupConstrain() {}
    
    open func bindViewModel() {}
    
    open func refreshView() {}
    
    open func setupNaviBar() {}
    
}
