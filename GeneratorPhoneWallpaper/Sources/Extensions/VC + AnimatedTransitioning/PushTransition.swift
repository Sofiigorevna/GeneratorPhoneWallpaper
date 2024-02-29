//
//  PushTransition.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 28.02.2024.
//

import UIKit

class PushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)

        // Set the initial scale of the toView
        toView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)

        // Use UIViewPropertyAnimator for the animation
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.7) {
            toView.transform = .identity
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        animator.startAnimation()
    }


}

