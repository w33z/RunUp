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

class MapViewController: UIViewController {

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        
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
                
                UIView.transition(with: menuButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    self.menuButton.setImage(UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    self.menuButton.imageView?.tintColor = .white
                }, completion: nil)
            } else {
                
                UIView.transition(with: menuButton, duration: 0.5, options: .transitionFlipFromRight, animations: {
                    self.menuButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    self.menuButton.imageView?.tintColor = .black
                }, completion: nil)
            }
        }
    }
    
    var delegate: CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
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
