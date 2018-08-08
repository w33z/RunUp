//
//  HomeMapViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 06/07/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class HomeMapViewController: UIViewController {

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

