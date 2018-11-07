//
//  WorkoutPanelView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 24/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class WorkoutPanelView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: -5, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(activityDidChange), name: Notification.Name.ActivityDidChangeNotification, object: nil)
    }
}

extension WorkoutPanelView {
    
    @objc func activityDidChange() {
        titleLabel.text = Settings.instance.activity.rawValue.uppercased()
    }
}

extension Notification.Name {
    static let ActivityDidChangeNotification = Notification.Name("ActivityDidChangeNotification")
}
