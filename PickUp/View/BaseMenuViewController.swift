//
//  BaseMenuViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 06/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class BaseMenuViewController: UIViewController {
    
    lazy var popBarButton: UIBarButtonItem = {
        let image = UIImage(named: "arrow")!.withRenderingMode(.alwaysTemplate)
        
        let button = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(popBarButtonTapped))
        
        button.tintColor = .darkGray
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addSubviews()
        addConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func popBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension BaseMenuViewController {
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]

        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = popBarButton
    }
    
    fileprivate func addSubviews() {
        view.backgroundColor = .cBG
    }
    
    fileprivate func addConstraints() {
        
    }
}
