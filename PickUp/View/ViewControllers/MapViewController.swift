//
//  MapViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 06/07/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        return mapView
    }()
    
    var menuButton: UIButton = {
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "menu"), for: .normal)
        leftButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        return leftButton
    }()
    
    var isOpen: Bool = false {
        didSet {
            if isOpen {
                
                UIView.transition(with: menuButton, duration: 0.5, options: .transitionFlipFromRight, animations: {
                    self.menuButton.setImage(UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    self.menuButton.imageView?.tintColor = .white
                }, completion: nil)
            } else {
                
                UIView.transition(with: menuButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    self.menuButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    self.menuButton.imageView?.tintColor = .black
                }, completion: nil)
            }
        }
    }
    
    var delegate: CenterViewControllerDelegate?
    var locationManager: CLLocationManager!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
    }
    
    @objc func menuButtonTapped() {

        if !isOpen {
            delegate?.toggleLeftPanel()
            isOpen = !isOpen
        } else {
            delegate?.closeLeftPanel()
        }
        
        view.bringSubview(toFront: menuButton)
    }
}

extension MapViewController {
    
    fileprivate func addSubviews() {
        
        view.addSubview(mapView)
        view.addSubview(menuButton)
    }
    
    fileprivate func addConstraints() {
        
        menuButton.snp.makeConstraints({ (make) in
            make.top.equalTo(view).offset(60)
            make.leading.equalTo(view).offset(25)
            make.width.height.equalTo(20)
        })
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = manager.location?.coordinate else { return }

        print(coordinate)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
