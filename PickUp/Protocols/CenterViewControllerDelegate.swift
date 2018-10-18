//
//  CenterViewControllerDelegate.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 01/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import UIKit.UIViewController

@objc protocol CenterViewControllerDelegate {
    @objc optional var navi: UINavigationController? { get set }
    @objc func toggleLeftPanel()
    @objc func closeLeftPanel()
    @objc func addLeftPanelViewController()
    @objc func animateLeftPanel(shouldExpand: Bool)
}
