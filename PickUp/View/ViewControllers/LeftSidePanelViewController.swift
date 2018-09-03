//
//  LeftSidePanelViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 01/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class LeftSidePanelViewController: UIViewController {
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(gradientViewTapped(_ :)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    private let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "LeftSidePanelTableViewCell", bundle: nil), forCellReuseIdentifier: LEFTSIDEPANELCELL)
        return tableView
    }()
    
    lazy var profileImageView: UIView = {
        let view = UIView.instanceFromNib(name: "ProfileImageView") as! ProfileImageView
        return view
    }()
    
    private let menuItems: [MenuItem] = [MenuItem(title: "History", imageName: .clock), MenuItem(title: "About app", imageName: .info), MenuItem(title: "Settings", imageName: .settings)]
    
    var delegate: CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        addSubviews()
        addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientView.makeGradientView()
    }
    
    @objc fileprivate func gradientViewTapped(_ sender: UITapGestureRecognizer) {
        delegate?.closeLeftPanel()
        
        let profileViewController = ControllersFactory.allocController(.ProfileCtrl) as! ProfileViewController
        
        self.present(profileViewController, animated: true, completion: nil)
    }
}

extension LeftSidePanelViewController {
    
    fileprivate func addSubviews() {

        view.addSubview(gradientView)
        gradientView.addSubview(profileImageView)
        view.addSubview(whiteView)
        view.addSubview(menuTableView)
    }
    
    fileprivate func addConstraints() {
        
        gradientView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 3)
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview()
        }

        whiteView.snp.makeConstraints { (make) in
            make.top.equalTo(gradientView.snp.bottom).offset(-50)
            make.leading.trailing.equalToSuperview()
            make.height.width.equalToSuperview()
        }

        menuTableView.snp.makeConstraints { (make) in
            make.top.equalTo(gradientView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}


extension LeftSidePanelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LEFTSIDEPANELCELL, for: indexPath) as? LeftSidePanelTableViewCell else { return UITableViewCell() }
        
        if (indexPath.row == 0) {
            cell.contentView.addTopBorder(color: UIColor.lightGray, thickness: 0.5)
        }
        
        let menuItem = menuItems[indexPath.row]
        cell.configureCell(menuItem: menuItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
}
