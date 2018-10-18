//
//  MapPanelView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 18/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class MapPanelView: UIView {
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var activityView: UIView!
    
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var workoutImageView: UIImageView!
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var workoutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    fileprivate func setupView() {
        startButton.makeShadowRounded(radius: 10)
        activityView.makeShadowRounded(radius: 10)
        
        activityImageView.image = activityImageView.image?.withRenderingMode(.alwaysTemplate)
        workoutImageView.image = workoutImageView.image?.withRenderingMode(.alwaysTemplate)
        activityImageView.tintColor = UIColor.cLightBlue
        workoutImageView.tintColor = UIColor.cLightBlue
    }
}
