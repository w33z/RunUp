//
//  AboutAppViewController.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 06/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class AboutAppViewController: BaseMenuViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addSubviews()
        addConstraints()
    }
}

extension AboutAppViewController {
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "About App"
    }
    
    fileprivate func addSubviews() {

    }
    
    fileprivate func addConstraints() {

    }
}
