//
//  BaseMenuViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 06/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class BaseMenuViewController: UIViewController {
    
    var popButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        button.imageView?.tintColor = .darkGray
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        roratePopButton()
    }
    
    @objc func menuButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension BaseMenuViewController {
    
    fileprivate func addSubviews() {
        addBlurBackgroundView()
        
        view.addSubview(popButton)
    }
    
    fileprivate func addConstraints() {
        
        popButton.snp.makeConstraints({ (make) in
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
    
    fileprivate func roratePopButton() {
        UIView.animate(withDuration: 0.25) {
            self.popButton.imageView?.transform = CGAffineTransform(rotationAngle: -.pi)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0.2, options: .curveEaseIn, animations: {
            self.popButton.imageView?.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        }, completion: nil)
    }
}
