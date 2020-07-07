//
//  HomeViewController+Extensions.swift
//  GCAddonsExamplesPlayground
//
//  Created by Guy Cohen on 05/07/2020.
//  Copyright © 2020 GCAddons. All rights reserved.
//

import UIKit

extension HomeViewController {
    
    func setupUI(){
        outletMessageLabel.alpha = 0
        outletButtonSignIn.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTextFieldsBackground()
        fadeInOutlets()
    }
    
    func fadeInOutlets() {
        self.view.layoutIfNeeded()
        self.outletButtonSignIn.transform = CGAffineTransform(translationX: 0, y: 50)
        UIView.animate(withDuration: 0.5, delay: 0.8, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.outletMessageLabel.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 0.3) {
                self.outletButtonSignIn.alpha = 1
                self.outletButtonSignIn.transform = .identity
            }
        }
    }
    
    func animateTextFieldsBackground() {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.1, 1.0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.5
        animation.repeatCount = 1
        backgroundForTextFields.layer.add(animation, forKey: nil)
    }
    
    func animateViews(_ views: [UIView], shouldHide: Bool) {
        UIView.animate(withDuration: 0.3) { views.forEach { $0.alpha = shouldHide ? 0 : 1 } }
    }
}
