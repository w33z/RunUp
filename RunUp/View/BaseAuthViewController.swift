//
//  BaseAuthViewController.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 02/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import RxSwift
import RxCocoa

class BaseAuthViewController: UIViewController, NVActivityIndicatorViewable {
    
    private let gradientView: UIView = {
        let view = UIView()
        return view
    }()

    private let logoBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Sign Up", comment: "")
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()

    let backgroundView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.makeShadowRounded(radius: 25)
        return view
    }()
    
    var backgroundViewHeightConsraint: Constraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientView.makeGradientView()
    }
    
    func showAlertController(title: String, message: String, completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            alert.dismiss(animated: true, completion: completion)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func startAnimating(message: String) {
        NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = UIFont.systemFont(ofSize: 20)
        startAnimating(CGSize(width: 120, height: 120), message: message, messageFont: nil, type: .ballTrianglePath, color: UIColor.cLightBlue, padding: 25, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: UIColor.white, fadeInAnimation: NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
    }
}

extension BaseAuthViewController {
    fileprivate func addSubviews() {
        view.backgroundColor = .cWhite

        view.addSubview(gradientView)
        view.addSubview(logoBGView)
        logoBGView.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(backgroundView)
    }
    
    fileprivate func makeConstraints() {
        
        gradientView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 2)
        }
        
        logoBGView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(view.frame.height / 12)
            make.centerX.equalTo(view)
            make.width.height.equalTo(120)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 10, left: 5, bottom: 5, right: 10))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoBGView.snp.bottom).offset(20)
            make.centerX.equalTo(logoBGView)
        }
        
        backgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(gradientView.snp.bottom).offset(-80)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            self.backgroundViewHeightConsraint = make.height.equalTo(view.frame.height / 2.5).constraint
        }
    }
}
