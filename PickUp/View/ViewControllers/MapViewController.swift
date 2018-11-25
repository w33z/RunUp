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

class MapViewController: UIViewController, LocationInjectorProtocol {

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
        
//        view.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
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
    
    private lazy var workoutPanelView: WorkoutPanelView = {
        let view = UIView.instanceFromNib(name: "WorkoutPanelView") as! WorkoutPanelView
        
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
    
    let viewmodel = MapViewModel()
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
        mapView.userTrackingMode = .followWithHeading
        
        addSubviews()
        addConstraints()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        centerMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
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
    @IBAction func pauseResumeWorkoutButtonTapped(_ sender: UIButton) {
        
        if viewmodel.isPaused {
            sender.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate), for: .normal)
            viewmodel.resumeWorkout()
            
        } else {
            sender.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
            viewmodel.pauseWorkout()

        }
    }
    
    @objc func workoutDidStart() {
        workoutPanelView.configure(workout: viewmodel.workout)
    }
    
    var mapViewBottomConstraint: Constraint?
    var workoutPanelBottomConstraint: Constraint?
    
    var isEnable: Bool = false
    
    @IBAction func startButtonTapped(_ sender: Any) {

        mapViewBottomConstraint?.update(inset: workoutPanelView.frame.height)
        workoutPanelBottomConstraint?.update(inset: 0)

        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.viewmodel.startWorkout()
           NotificationCenter.default.addObserver(self, selector: #selector(self.workoutDidStart), name: Notification.Name.WorkoutDidStartNotification, object: nil)
            self.isEnable = !self.isEnable
        })
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        
        mapViewBottomConstraint?.update(offset: workoutPanelView.frame.height)
        workoutPanelBottomConstraint?.update(offset: 350)
        
        viewmodel.stopWorkout()
        workoutPanelView.reset()
        
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name.WorkoutDidStartNotification, object: nil)

        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.isEnable = !self.isEnable
        })
    }
}

extension MapViewController {
    
    fileprivate func addSubviews() {
        
        view.addSubview(mapView)
        view.addSubview(menuButton)
        view.addSubview(panelView)
        view.addSubview(centerMapView)
        view.addSubview(workoutPanelView)
    }
    
    fileprivate func addConstraints() {
        
        menuButton.snp.makeConstraints({ (make) in
            make.top.equalTo(view).offset(60)
            make.leading.equalTo(view).offset(25)
            make.width.height.equalTo(20)
        })
        
        mapView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            self.mapViewBottomConstraint = make.bottom.equalToSuperview().constraint
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
        
        workoutPanelView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            self.workoutPanelBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(350).constraint
            make.height.equalTo(330)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locat = manager.location else { return }
        guard let coordinate = manager.location?.coordinate else { return }

        location.setCordinates(coordinate.latitude, coordinate.longitude)
        
        if isEnable {
            let myLocations = viewmodel.locations
            viewmodel.locations.append(locations.first!)

            let region = MKCoordinateRegion(center: coordinate, span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)
            
            if myLocations.count > 1 {
                let sourceIndex = myLocations.count - 1
                let destinationIndex = myLocations.count - 2
                
                let coords1 = myLocations[sourceIndex].coordinate
                let coords2 = myLocations[destinationIndex].coordinate
                
                var a = [coords1, coords2]
                let polyline = MKGeodesicPolyline(coordinates: &a, count: a.count)
                mapView.addOverlay(polyline)
                
                let distance = myLocations[sourceIndex].distance(from: myLocations[destinationIndex])
                viewmodel.workout.distance += distance
            }
            
            if let workout = viewmodel.workout {
                workout.speed = locat.speed
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let overlay = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.cBlue
            polylineRenderer.lineWidth = 4
            
            return polylineRenderer
        }
        
        fatalError("Something wrong...")
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

extension Notification.Name {
    static let WorkoutDidStartNotification = Notification.Name("WorkoutDidStartNotification")
}
