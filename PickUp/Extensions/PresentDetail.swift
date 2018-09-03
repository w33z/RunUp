//
//  PresentDetail.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 15/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    
    func pushRevealDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionReveal
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionFromRight
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionFromLeft
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
    func dismissRevealDetail() {
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionReveal
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
    func dismissDetail(completion: @escaping () -> ()) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionFromLeft
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: completion)
    }
}
