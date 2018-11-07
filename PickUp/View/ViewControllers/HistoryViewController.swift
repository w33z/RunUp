//
//  HistoryViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 06/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class HistoryViewController: BaseMenuViewController, LocationInjectorProtocol{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addSubviews()
        addConstraints()
    }
}

extension HistoryViewController {
    
    fileprivate func setupNavigationBar() {

        navigationItem.title = "History"
    }
    
    fileprivate func addSubviews() {

    }
    
    fileprivate func addConstraints() {

    }
}
