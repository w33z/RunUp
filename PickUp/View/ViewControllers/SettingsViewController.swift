//
//  SettingsViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 06/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import SelectionDialog

class SettingsViewController: BaseMenuViewController {
    
    let tableView: UITableView = {
        let table = UITableView()
        
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 15, right: 0)
        table.backgroundColor = .cBG
        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: SettingTableViewCell.REUSE_IDENTIFIER)

        setupNavigationBar()
        addSubviews()
        addConstraints()
        
    }
}

extension SettingsViewController {
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Settings"
    }
    
    fileprivate func addSubviews() {
        view.addSubview(tableView)
    }
    
    fileprivate func addConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
           return "Display"
        } else {
            return "Map"
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.instanceFromNib(name: "SettingTableViewHeader") as! SettingTableViewHeader

        let sectionTitle: String

        if section == 0 {
            sectionTitle = "Display"
        } else {
            sectionTitle = "Map"
        }

        header.headerTitle.text = sectionTitle
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.REUSE_IDENTIFIER) as? SettingTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            switch indexPath.row {
                case 0:
                    cell.configureCell(title: NSLocalizedString("Distance", comment: ""), options: Settings.instance.distance)
                case 1:
                    cell.configureCell(title: NSLocalizedString("Speed", comment: ""), options:  Settings.instance.speed)
                case 2:
                    cell.configureCell(title: NSLocalizedString("Deegres", comment: ""), options:  Settings.instance.deegres)
                default:
                    break
            }
        } else {
            cell.showSwitch()
            cell.configureCell(title: NSLocalizedString("Satellite", comment: ""), options: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! SettingTableViewCell
            configureDialog(cell: cell)
        }
    }
}

extension SettingsViewController {
    
    private func configureDialog(cell: SettingTableViewCell) {
        let dialog = SelectionDialog(title: cell.titleLabel.text!, closeButtonTitle: NSLocalizedString("Close", comment: ""))
        
        switch cell.titleLabel.text! {
        case "Distance":
            dialog.addItem(item: SettingOptions.Miles.rawValue) {
                Settings.instance.distance = .Miles
                dialog.close()
                self.tableView.reloadData()
            }
            dialog.addItem(item: SettingOptions.Kilometers.rawValue) {
                Settings.instance.distance = .Kilometers
                dialog.close()
                self.tableView.reloadData()
            }
        case "Speed":
            dialog.addItem(item: SettingOptions.Mph.rawValue) {
                Settings.instance.speed = .Mph
                dialog.close()
                self.tableView.reloadData()
            }
            dialog.addItem(item: SettingOptions.Kmh.rawValue) {
                Settings.instance.speed = .Kmh
                dialog.close()
                self.tableView.reloadData()
            }
        case "Deegres":
            dialog.addItem(item: SettingOptions.Fahrenheit.rawValue) {
                Settings.instance.deegres = .Fahrenheit
                dialog.close()
                self.tableView.reloadData()
            }
            dialog.addItem(item: SettingOptions.Celsius.rawValue) {
                Settings.instance.deegres = .Celsius
                dialog.close()
                self.tableView.reloadData()
            }
        default:
            break
        }
        
        dialog.show()
    }
}
