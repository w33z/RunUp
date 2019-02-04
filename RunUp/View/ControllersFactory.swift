//
//  ControllersFactory.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 02/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

enum ControllerType: String {
    case MainCtrl = "MainViewController"
    case LoginCtrl = "LoginViewController"
    case RegisterCtrl = "RegisterViewController"
    case ResetPasswordCtrl = "ResetPasswordViewController"
    case MapCtrl = "MapViewController"
    case SlideMenuCtrl = "SlideMenuViewController"
    case LeftSideCtrl = "LeftSidePanelViewController"
    case ProfileCtrl = "ProfileViewController"
    case SummaryCtrl = "SummaryCollectionViewController"
    case HistoryCtrl = "HistoryViewController"
    case AboutAppCtrl = "AboutAppViewController"
    case SettingsCtrl = "SettingsViewController"
    case WorkoutDetailsCtrl = "WorkoutDetailsViewController"
}

class ControllersFactory {
    
    static func allocController(_ controllerType: ControllerType) -> UIViewController {
        
        let className: String = "RunUp.\(controllerType.rawValue)"
        let aClass = NSClassFromString(className) as! UIViewController.Type
        let viewController = aClass.init()
        
        return viewController
    }
    
    static func allocController(_ controllerType: ControllerType, with viewControllers: [UIViewController]) -> UIViewController {
        
        var viewControllers = viewControllers
        let viewController = self.allocController(controllerType)
        
        let navigationViewController: UINavigationController = viewController as! UINavigationController
        viewControllers.insert(navigationViewController.viewControllers.first!, at: 0)
        navigationViewController.setViewControllers(viewControllers, animated: false)
        
        return viewController
    }
}

