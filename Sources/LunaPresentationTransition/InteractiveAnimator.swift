//
//  InteractiveAnimator.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/14.
//

import UIKit

public class InteractiveAnimator: UIPercentDrivenInteractiveTransition {
	var configuration: CustomTransitionConfiguration
	var context: UIViewControllerContextTransitioning?
	init(_ configuration: CustomTransitionConfiguration) {
		self.configuration = configuration
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return configuration.duration
	}
	
	override public func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
		super.startInteractiveTransition(transitionContext)
		self.context = transitionContext
		if let start = configuration.interactiveTransitionStarter {
			start(self, transitionContext)
		}
	}
	
	func handleUpdate(sender: AnyObject) {
		if let handler = configuration.handleUpdateClosure {
			handler(self, sender)
		}
	}
}
