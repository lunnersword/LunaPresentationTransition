//
//  InteractiveAnimator.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/14.
//

import UIKit

class InteractiveAnimator: UIPercentDrivenInteractiveTransition {
	var configuration: CustomTransitionConfiguration
	var context: UIViewControllerContextTransitioning?
	init(_ configuration: CustomTransitionConfiguration) {
		self.configuration = configuration
	}
	
	override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
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
