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
        leftButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.imageView?.tintColor = .darkGray
        leftButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        return leftButton
    }()
    
    private lazy var panelView: MapPanelView = {
        let view = UIView.instanceFromNib(name: "MapPanelView") as! MapPanelView
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesturePanelView(_:)))
        view.addGestureRecognizer(pan)
        return view
    }()
    
    private lazy var centerMapView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        
        let imageView = UIImageView(image: UIImage(named: "center")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints({ (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview().offset(-10)
        })
        
        view.makeShadowRounded(radius: 25)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(centerMap))
        view.addGestureRecognizer(tap)
        
        return view
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
                    self.menuButton.imageView?.tintColor = .darkGray
                }, completion: nil)
            }
        }
    }
    
    var delegate: CenterViewControllerDelegate?
    var locationManager: CLLocationManager!
    
    var panelUpOffset: CGFloat = 100
    var panelUp: CGPoint!
    var panelDown: CGPoint!
    var centerButtonUp: CGPoint!
    var centerButtonDown: CGPoint!
    var isCollapsed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        mapView.delegate = self
        
        addSubviews()
        addConstraints()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        
        centerMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        panelDown = panelView.center
        centerButtonDown = centerMapView.center
        panelUp = CGPoint(x: panelView.center.x, y: panelView.center.y - panelUpOffset)
        centerButtonUp = CGPoint(x: centerMapView.center.x, y: centerMapView.center.y - panelUpOffset)
    }
    
    @objc func menuButtonTapped() {

        if !isOpen {
            delegate?.toggleLeftPanel()
            isOpen = !isOpen
        } else {
            delegate?.closeLeftPanel()
        }
        
//        view.bringSubviewToFront(menuButton)
    }
    
    @objc func centerMap() {
        
        guard let coordinate = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
        
        centerMapView.fadeTo(alphaValue: 0.0, withDuration: 0.2)
    }
}

extension MapViewController {
    
    fileprivate func addSubviews() {
        
        view.addSubview(mapView)
        view.addSubview(menuButton)
        view.addSubview(panelView)
        view.addSubview(centerMapView)
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
        
        panelView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-65)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(265)
        }
        
        centerMapView.snp.makeConstraints { (make) in
            make.bottom.equalTo(panelView.snp.top).offset(-25)
            make.trailing.equalTo(panelView).offset(-25)
            make.width.height.equalTo(50)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let coordinate = manager.location?.coordinate else { return }
//
//        print(coordinate)
//        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        centerMapView.fadeTo(alphaValue: 1.0, withDuration: 0.2)
    }

}

extension MapViewController: UIGestureRecognizerDelegate {
    
    @objc func handlePanGesturePanelView(_ recognizer: UIPanGestureRecognizer) {
        
        let gestureIsDraggingFromDownToUp = (recognizer.velocity(in: view).y < 0)

        switch recognizer.state {

            case .changed:
                if let rview = recognizer.view {
                    
                    if (isCollapsed && gestureIsDraggingFromDownToUp) {
                        break
                    } else {
                        rview.center.y = rview.center.y + recognizer.translation(in: view).y
                        recognizer.setTranslation(.zero, in: view)
                    }
                }
            
            case .ended:
                if let rview = recognizer.view {
                    
                    if gestureIsDraggingFromDownToUp {
                        
                        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                            rview.center = self.panelUp
                            self.centerMapView.center = self.centerButtonUp
                            self.panelView.backgroundView.alpha = 0.98
                            self.panelView.activityView.alpha = 1
                        }) { (_) in
                            self.isCollapsed = true
                        }

                    } else {

                        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                            rview.center = self.panelDown
                            self.centerMapView.center = self.centerButtonDown
                            self.panelView.backgroundView.alpha = 0
                            self.panelView.activityView.alpha = 0
                        }) { (_) in
                            self.isCollapsed = false
                        }
                    }
                }
            
            default:
                break
        }
    }
}
