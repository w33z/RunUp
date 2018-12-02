//
//  HistoryViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 06/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryViewController: BaseMenuViewController, LocationInjectorProtocol {
    
    private lazy var workoutTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: HistoryTableViewCell.identifier)
        
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        table.separatorStyle = .none
        table.alwaysBounceHorizontal = false
        table.showsHorizontalScrollIndicator = false
        return table
    }()
    
    let viewmodel = HistoryViewModel()
    
    private var workouts: [Workout]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addSubviews()
        addConstraints()
        
        viewmodel.fetchWorkouts { (workouts) in
            self.workouts = workouts
        }
    }
}

extension HistoryViewController {
    
    fileprivate func setupNavigationBar() {

        navigationItem.title = "History"
    }
    
    fileprivate func addSubviews() {
        view.addSubview(workoutTable)
    }
    
    fileprivate func addConstraints() {
        workoutTable.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
        
        let workout = workouts[indexPath.row]
        cell.configureCell(workout: workout)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = workouts[indexPath.row]
        
        let workoutDetails = ControllersFactory.allocController(.WorkoutDetailsCtrl) as! WorkoutDetailsViewController
        workoutDetails.workout = workout
        
        navigationController?.pushViewController(workoutDetails, animated: true)
    }
}
