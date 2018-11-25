//
//  HistoryTableViewCell.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 25/11/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier = "HistoryTableViewCellIdentifier"

    override func awakeFromNib() {
        super.awakeFromNib()

        let inset = UIEdgeInsets(top: 15, left: 5, bottom: 5, right: 15)
        contentView.frame = contentView.frame.inset(by: inset)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(workout: Workout) {
        activityLabel.text = "\(String(describing: ActivityOptions(rawValue: workout.activity.rawValue)!.name()))"
        workoutLabel.text = "\(String(describing: WorkoutOptions(rawValue: workout.workout.rawValue)!.name()))"
        
        timeLabel.text = workout.time.getFormattedString()

        let distanceUnit = Settings.instance.distance == .Miles ? "mi." : "km."
        let distance = workout.distance * (Settings.instance.distance == .Miles ? 0.00062137 : 0.001)
        distanceLabel.text = String(format: "%.1f", distance) + " \(distanceUnit)"

        dateLabel.text = workout.date.getFormattedString()
    }
    
}
