//
//  MapPanelView.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 18/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import SelectionDialog

class MapPanelView: UIView {
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var activityView: UIView!
    
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var workoutImageView: UIImageView!
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var workoutLabel: UILabel!
    
    @IBOutlet weak var activView: UIView!
    @IBOutlet weak var workoutView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        registerGestures()
    }
    
    fileprivate func setupView() {
        startButton.makeShadowRounded(radius: 10)
        activityView.makeShadowRounded(radius: 10)
        
        activityImageView.image = activityImageView.image?.withRenderingMode(.alwaysTemplate)
        workoutImageView.image = workoutImageView.image?.withRenderingMode(.alwaysTemplate)
        activityImageView.tintColor = UIColor.cLightBlue
        workoutImageView.tintColor = UIColor.cLightBlue
    }
    
    fileprivate func registerGestures() {
        let activityTap = UITapGestureRecognizer(target: self, action: #selector(activityViewTapped))
        let workoutTap = UITapGestureRecognizer(target: self, action: #selector(workoutViewTapped))
        
        activView.addGestureRecognizer(activityTap)
        workoutView.addGestureRecognizer(workoutTap)
    }
    
    @objc func activityViewTapped() {
        let dialog = SelectionDialog(title: NSLocalizedString("Activity", comment: ""), closeButtonTitle: NSLocalizedString("Close", comment: ""))
        
        dialog.addItem(item: "Walking") {
            self.activityLabel.text = "Walking"
            Settings.instance.activity = .Walking
            dialog.close()
        }
        dialog.addItem(item: "Running") {
            self.activityLabel.text = "Running"
            Settings.instance.activity = .Running
            dialog.close()
        }
        dialog.addItem(item: "Cycling") {
            self.activityLabel.text = "Cycling"
            Settings.instance.activity = .Cycling
            dialog.close()
        }
        
        dialog.show()
    }
    
    @objc func workoutViewTapped() {
        let dialog = SelectionDialog(title: "Workout", closeButtonTitle: NSLocalizedString("Close", comment: ""))

        dialog.addItem(item: "Tranning") {
            self.workoutLabel.text = "Tranning"
            Settings.instance.workout = .Tranning
            dialog.close()
        }
        dialog.addItem(item: "Speed") {
            self.workoutLabel.text = "Speed"
            Settings.instance.workout = .Speed
            dialog.close()
        }
        dialog.addItem(item: "Distance") {
            self.workoutLabel.text = "Distance"
            Settings.instance.workout = .Distance
            dialog.close()
        }
        
        dialog.show()
    }
}
