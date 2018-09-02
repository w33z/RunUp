//
//  LeftSidePanelViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 01/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class LeftSidePanelViewController: UIViewController {
    
    private let gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        return view
    }()
    
    private let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let profileImageView: UIImageView = {
        let image = UIImage(named: "avatar")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Fullname"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientView.makeGradientView()
    }
    
    @objc fileprivate func profileImageViewTapped() {
        
    }
}

extension LeftSidePanelViewController {
    
    fileprivate func addSubviews() {
        
        view.addSubview(gradientView)
        gradientView.addSubview(profileImageView)
        gradientView.addSubview(fullnameLabel)
        view.addSubview(whiteView)
        view.addSubview(menuTableView)


    }
    
    fileprivate func addConstraints() {
        
        gradientView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 2.5)
        }
        
        whiteView.snp.makeConstraints { (make) in
            make.top.equalTo(gradientView.snp.bottom).offset(-45)
            make.leading.trailing.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.width.height.equalTo(80)
        }
        
        fullnameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        menuTableView.snp.makeConstraints { (make) in
            make.top.equalTo(gradientView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
