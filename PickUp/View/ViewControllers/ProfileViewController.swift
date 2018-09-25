//
//  ProfileViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 02/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var menuButton: UIButton = {
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "arrow"), for: .normal)
        leftButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        return leftButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rotate360MenuButton()
    }
    
    @objc func menuButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileViewController {
    
    fileprivate func addSubviews() {
        addBlurBackgroundView()

        view.addSubview(menuButton)
    }
    
    fileprivate func addConstraints() {
        
        menuButton.snp.makeConstraints({ (make) in
            make.top.equalTo(view).offset(60)
            make.leading.equalTo(view).offset(25)
            make.width.height.equalTo(20)
        })
    }
    
    fileprivate func addBlurBackgroundView() {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    fileprivate func rotate360MenuButton() {
        UIView.animate(withDuration: 0.35) {
            self.menuButton.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        }
        
        UIView.animate(withDuration: 0.35, delay: 0.3, options: .curveEaseIn, animations: {
            self.menuButton.imageView?.transform = CGAffineTransform(rotationAngle: .pi * 2.0)
        }, completion: nil)
    }
}
