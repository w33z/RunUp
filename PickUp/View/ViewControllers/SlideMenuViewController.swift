//
//  SlideMenuViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 01/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}

var controllerType: ControllerType = .MapCtrl

class SlideMenuViewController: UIViewController {
    
    var mapViewController: MapViewController!
    var leftSidePanelViewController: LeftSidePanelViewController!
    var centerViewController: UIViewController!
    var currentState: SlideOutState = .collapsed {
        didSet {
            let shouldShowShadow = (currentState != .collapsed)
            
            shouldShowShadowForCenterViewController(status: shouldShowShadow)
        }
    }
    
    var isHidden = false
    let centerPanelExpandedOffset: CGFloat = 100
    var centerPanel: CGFloat!

    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        initCenter(for: controllerType)
    }
    
    func initCenter(for ctrlType: ControllerType) {
        var presentingViewController: UIViewController
        
        controllerType = ctrlType
        
        if mapViewController == nil {
            mapViewController = ControllersFactory.allocController(.MapCtrl) as! MapViewController
            mapViewController.delegate = self
        }
        
        presentingViewController = mapViewController
        
        if let center = centerViewController {
            center.view.removeFromSuperview()
            center.removeFromParentViewController()
        }
        
        centerViewController = presentingViewController
        
        view.addSubview(centerViewController.view)
        addChildViewController(centerViewController)
        centerViewController.didMove(toParentViewController: self)
        
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }
}

extension SlideMenuViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        
        if leftSidePanelViewController == nil {
            leftSidePanelViewController = ControllersFactory.allocController(.LeftSideCtrl) as! LeftSidePanelViewController
            leftSidePanelViewController.view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.size.width - centerPanelExpandedOffset, height: view.frame.size.height))
            
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(closeLeftPanel))
            swipe.direction = .left
            leftSidePanelViewController.view.addGestureRecognizer(swipe)
            leftSidePanelViewController.delegate = self
            
            addChildSidePanelViewController(leftSidePanelViewController)
        }
    }
    
    
    func animateLeftPanel(shouldExpand: Bool) {
        centerPanel = centerViewController.view.frame.width - centerPanelExpandedOffset

        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            
            setupBlackCoverView()
            currentState = .leftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: centerPanel)

        } else {
            closeLeftPanel()
        }
    }
    
    @objc func closeLeftPanel() {
        isHidden = !isHidden
        mapViewController.isOpen = false
        
        animateStatusBar()
        hideBlackCoverView()
        animateCenterPanelXPosition(targetPosition: 0, completion: { (finished) in
            if finished == true {
                self.currentState = .collapsed
                self.leftSidePanelViewController = nil
            }
        })
    }
}

extension SlideMenuViewController {
    
    func setupBlackCoverView() {
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.black
        whiteCoverView.tag = 25
        
        centerViewController.view.addSubview(whiteCoverView)
        whiteCoverView.fadeTo(alphaValue: 0.75, withDuration: 0.2)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        
        centerViewController.view.addGestureRecognizer(tap)
    }
    
    func hideBlackCoverView() {
        centerViewController.view.removeGestureRecognizer(tap)
        for subview in centerViewController.view.subviews {
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }, completion: { (finished) in
                    subview.removeFromSuperview()
                })
            }
        }
    }
    
    func addChildSidePanelViewController(_ sidePanelController: UIViewController) {
        view.insertSubview(sidePanelController.view, at: 0)
        view.bringSubview(toFront: sidePanelController.view)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func shouldShowShadowForCenterViewController(status: Bool) {
        
        if status == true {
            
            let layer: CAGradientLayer = CAGradientLayer()
            layer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
            layer.frame = CGRect(origin: CGPoint(x: 0.4, y: 0), size: CGSize(width: 5, height: centerViewController.view.frame.height))
            
            centerViewController.view.layer.addSublayer(layer)
        } else {

            for (i,layer) in centerViewController.view.layer.sublayers!.enumerated() {
                if (layer.isKind(of: CAGradientLayer.self)) {
                    centerViewController.view.layer.sublayers?.remove(at: i)
                }
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            guard let centerPanel = self.centerPanel else { return }
            
            self.leftSidePanelViewController.view.frame.origin.x = (targetPosition != 0) ? 0 : (-centerPanel)
            self.centerViewController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
}
