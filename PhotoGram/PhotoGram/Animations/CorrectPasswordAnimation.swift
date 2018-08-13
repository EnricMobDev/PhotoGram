//
//  CorrectPasswordAnimation.swift
//  SigInApplication
//
//  Created by Enric Pou Villanueva on 7/8/18.
//  Copyright © 2018 Enric Pou Villanueva. All rights reserved.
//

import UIKit
import Lottie

class CorrectPasswordAnimation {
    
    // MARK: - Constants
    let animationView = UIView()
    let ANIMATION_NAME = "code_invite_success"
    
    public func showCorrectLoginAnimation() -> UIView {
        
        let animationView = LOTAnimationView.init(name: ANIMATION_NAME)
        animationView.frame = CGRect(x: 60, y: 5, width: 400, height: 400)
        animationView.contentMode = .scaleToFill
        
        animationView.play()
        
        return animationView
    }
}
