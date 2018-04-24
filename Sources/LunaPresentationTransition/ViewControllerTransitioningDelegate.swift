//
//  ViewControllerTransitioningDelegate.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/14.
//

import UIKit

public class ViewControllerTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
	let presentationConfiguration: CustomPresentationConfiguration?
	let presentTransitionConfiguration: CustomTransitionConfiguration?
	let dismissTransitionConfiguration: CustomTransitionConfiguration?

	public init(presentTransitionConfiguration: CustomTransitionConfiguration?, dismissTransitionConfiguration: CustomTransitionConfiguration?, presentationConfiguration: CustomPresentationConfiguration?) {
		self.presentationConfiguration = presentationConfiguration
		self.dismissTransitionConfiguration = dismissTransitionConfiguration
		self.presentTransitionConfiguration = presentTransitionConfiguration
	}
	
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		if let presentConfig = presentTransitionConfiguration, !presentConfig.isInteractive {
			return Animator(presentConfig)
		}
		return nil
	}
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		if let dismissConfiguration = dismissTransitionConfiguration, !dismissConfiguration.isInteractive {
			return Animator(dismissConfiguration)
		}
		return nil
	}
	public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		if let presentConfig = presentTransitionConfiguration, presentConfig.isInteractive {
			return InteractiveAnimator(presentConfig)
		}
		return nil
	}
	public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		if let dismissConfig = dismissTransitionConfiguration, dismissConfig.isInteractive {
			return InteractiveAnimator(dismissConfig)
		}
		return nil
	}
	
	public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		if let presentationConfig = presentationConfiguration {
			return PresentationController(presentedViewController: presented, presenting: presenting, configuration: presentationConfig)
		}
		return nil
	}
	
}
