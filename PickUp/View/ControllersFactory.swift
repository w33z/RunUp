//
//  ControllersFactory.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 02/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

enum ControllerType: String {
    case MainCtrl = "MainViewController"
    case LoginCtrl = "LoginViewController"
    case RegistrationCtrl = "RegistrationViewController"
    case ResetPasswordCtrl = "ResetPasswordViewController"
    case MapCtrl = "MapViewController"
}

class ControllersFactory {
    
    static func allocController(_ controllerType: ControllerType) -> UIViewController {
        
        let className: String = "PickUp.\(controllerType.rawValue)"
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

