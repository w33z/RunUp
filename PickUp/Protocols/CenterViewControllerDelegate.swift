//
//  CenterViewControllerDelegate.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 01/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

protocol CenterViewControllerDelegate {
    func toggleLeftPanel()
    func closeLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
