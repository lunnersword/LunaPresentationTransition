//
//  LunaTransitioner.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/14.
//

import UIKit

public class Animator: NSObject, UIViewControllerAnimatedTransitioning {
	var animationDictionary: [String: Any] = [:]
	let configuration: CustomTransitionConfiguration
	init(_ configuration: CustomTransitionConfiguration) {
		self.configuration = configuration
	}
	public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return configuration.duration
	}
	
	public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let  animate = configuration.animateTransition
		animate(self, transitionContext)
		
	}
	
	
}
