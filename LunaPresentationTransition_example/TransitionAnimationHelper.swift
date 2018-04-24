//
//  TransitionAnimationHelper.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/15.
//

import Foundation
import UIKit
class TransitionAnimationHelper: TransitionAnimationHelperDelegate {
	
	static func presentAnimator() -> AnimateTransition? {
		let isPresentation = true
		return { (animator: Animator, context: UIViewControllerContextTransitioning) in
			let fromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from)
			let fromView = context.view(forKey: UITransitionContextViewKey.from)
			let toViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to)
			let toView = context.view(forKey: UITransitionContextViewKey.to)
			let containerView: UIView = context.containerView
			if (isPresentation), let toView = toView {
				containerView.addSubview(toView)
			}
			let animatingViewController = isPresentation ? toViewController : fromViewController
			let animatingView = animatingViewController!.view
			
			let appearedFrame = context.finalFrame(for: animatingViewController!)
			var dismissedFrame = appearedFrame
			dismissedFrame.origin.y += dismissedFrame.size.height
			dismissedFrame.origin.x += dismissedFrame.size.width
			
			let initialFrame = isPresentation ? dismissedFrame : appearedFrame
			let finalFrame = isPresentation ? appearedFrame : dismissedFrame
			animatingView?.frame = initialFrame
			
			UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: .allowUserInteraction , animations: {
				animatingView?.frame = finalFrame
			}, completion: { (completed: Bool) in
				if !isPresentation {
					fromView?.removeFromSuperview()
				}
				context.completeTransition(true)
			})
			
		}
//		return transitionAnimator(presenting: true)
	}
	static func dismissAnimator() -> AnimateTransition? {
		let isPresentation = false
		return { (animator: Animator, context: UIViewControllerContextTransitioning) in
			let fromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from)
			let fromView = context.view(forKey: UITransitionContextViewKey.from)
			let toViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to)
			let toView = context.view(forKey: UITransitionContextViewKey.to)
			let containerView: UIView = context.containerView
			if (isPresentation), let toView = toView {
				containerView.addSubview(toView)
			}
			let animatingViewController = isPresentation ? toViewController : fromViewController
			let animatingView = animatingViewController!.view
			
			let appearedFrame = context.finalFrame(for: animatingViewController!)
			var dismissedFrame = appearedFrame
			dismissedFrame.origin.y += dismissedFrame.size.height
			dismissedFrame.origin.x += dismissedFrame.size.width
			
			let initialFrame = isPresentation ? dismissedFrame : appearedFrame
			let finalFrame = isPresentation ? appearedFrame : dismissedFrame
			animatingView?.frame = initialFrame
			
			UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: .allowUserInteraction , animations: {
				animatingView?.frame = finalFrame
			}, completion: { (completed: Bool) in
				if !isPresentation {
					fromView?.removeFromSuperview()
				}
				context.completeTransition(true)
			})
			
		}
//		return transitionAnimator(presenting: false)
	}
	static func transitionAnimator(presenting: Bool) -> AnimateTransition {
		let isPresentation = presenting
		return { (animator: Animator, context: UIViewControllerContextTransitioning) in
			let fromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from)
			let fromView = context.view(forKey: UITransitionContextViewKey.from)
			let toViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to)
			let toView = context.view(forKey: UITransitionContextViewKey.to)
			let containerView: UIView = context.containerView
			if (isPresentation), let toView = toView {
				containerView.addSubview(toView)
			}
			let animatingViewController = isPresentation ? toViewController : fromViewController
			let animatingView = animatingViewController!.view
			
			let appearedFrame = context.finalFrame(for: animatingViewController!)
			var dismissedFrame = appearedFrame
			dismissedFrame.origin.y += dismissedFrame.size.height
			dismissedFrame.origin.x += dismissedFrame.size.width
			
			let initialFrame = isPresentation ? dismissedFrame : appearedFrame
			let finalFrame = isPresentation ? appearedFrame : dismissedFrame
			animatingView?.frame = initialFrame
			
			UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: .allowUserInteraction , animations: {
				animatingView?.frame = finalFrame
			}, completion: { (completed: Bool) in
				if !isPresentation {
					fromView?.removeFromSuperview()
				}
				context.completeTransition(true)
			})
			
		}

	}
	
	// MARK: - Presentation Handlers
	static func presentationInitialization() -> PresentationInitialization? {
		return {
			let dimmingView: UIView = UIView()
			dimmingView.backgroundColor = UIColor.red.withAlphaComponent(0.4)
			dimmingView.alpha = 0.0
			$2.presentationDictionary["dimmingView"] = dimmingView
		}
	}
	
	static func presentationWillBegin() -> PresentationTransitionWillBeginClosure? {
		return {(presentation: PresentationController) in
			if let dimmingView: UIView = presentation.presentationDictionary["dimmingView"] as? UIView, let containerView = presentation.containerView {
				dimmingView.frame = containerView.bounds
				dimmingView.alpha = 0.0
				
				containerView.insertSubview(dimmingView, at: 0)
				
				if let coordinator = presentation.presentedViewController.transitionCoordinator {
					coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext!) in
						dimmingView.alpha = 1.0
						}, completion: nil)
				} else {
					dimmingView.alpha = 1.0
				}
			}
		}
	}
	
	static func presentationDidEnd() -> PresentationTransitionDidEndClosure? {
		return nil
	}
	
	static func dismissalWillBegin() -> DismissalTransitionWillBeginClosure? {
		return {
			if let dimmingView = $0.presentationDictionary["dimmingView"] as? UIView {
				if let coordinator = $0.presentedViewController.transitionCoordinator {
					coordinator.animate(alongsideTransition: {
						(context: UIViewControllerTransitionCoordinatorContext!) in
						dimmingView.alpha = 0.0
					}, completion: nil)
				} else {
					dimmingView.alpha = 0.0
				}
			}
		}
	}
	
	static func dismissalDidEnd() -> DismissalTransitionDidEndClosure? {
		return {
			(presentation, completed) in
			guard completed else {
				return
			}
			if let dimmingView = presentation.presentationDictionary["dimmingView"] as? UIView {
				dimmingView.removeFromSuperview()
			}
		}
	}
	
}
