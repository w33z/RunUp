//
//  LeftSidePanelViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 01/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import RealmSwift

class LeftSidePanelViewController: UIViewController {
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(gradientViewTapped(_ :)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "LeftSidePanelTableViewCell", bundle: nil), forCellReuseIdentifier: LEFTSIDEPANELCELL)
        return tableView
    }()
    
    lazy var profileImageView: ProfileImageView = {
        let view = UIView.instanceFromNib(name: "ProfileImageView") as! ProfileImageView
        return view
    }()
    
    private let menuItems: [MenuItem] = [MenuItem(title: "History", imageName: .clock), MenuItem(title: "About app", imageName: .info), MenuItem(title: "Settings", imageName: .settings), MenuItem(title: "Logout", imageName: .logout)]
    
    var delegate: CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        addSubviews()
        addConstraints()
        configureUserProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientView.makeGradientView()
    }
    
    func configureUserProfile() {
        let realm = try! Realm()
        let user = realm.objects(User.self).first
        
        profileImageView.configureProfileImageView(user: user)
    }
    
    @objc fileprivate func gradientViewTapped(_ sender: UITapGestureRecognizer) {
        delegate?.closeLeftPanel()
        
        let profileViewController = ControllersFactory.allocController(.ProfileCtrl) as! ProfileViewController
        delegate?.navi?!.pushViewController(profileViewController, animated: true)
    }
}

extension LeftSidePanelViewController {
    
    fileprivate func addSubviews() {

        view.addSubview(gradientView)
        gradientView.addSubview(profileImageView)
        view.addSubview(menuTableView)
    }
    
    fileprivate func addConstraints() {
        
        gradientView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 2.5)
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.leading.trailing.bottom.equalToSuperview()
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
        return CGFloat(65)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.closeLeftPanel()
        
        switch indexPath.row {
            case 0:
                let historyVC = ControllersFactory.allocController(.HistoryCtrl) as! HistoryViewController
                delegate?.navi?!.pushViewController(historyVC, animated: true)

            case 1:
                let aboutAppVC = ControllersFactory.allocController(.AboutAppCtrl) as! AboutAppViewController
                delegate?.navi?!.pushViewController(aboutAppVC, animated: true)

            case 2:
                let settingsApp = ControllersFactory.allocController(.SettingsCtrl) as! SettingsViewController
                delegate?.navi?!.pushViewController(settingsApp, animated: true)

            case 3:
                AuthService.instance.logout()
            
                let mainVC = ControllersFactory.allocController(.MainCtrl) as! MainViewController
                present(mainVC, animated: true, completion: nil)
            
            default:
                break
        }
    }
}
