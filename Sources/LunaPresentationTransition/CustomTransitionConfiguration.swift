//
//  CustomTransitionConfiguration.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/14.
//
import UIKit

typealias AnimateTransition = (Animator, UIViewControllerContextTransitioning) -> Void
typealias InteractiveTransitionStarter = (InteractiveAnimator, UIViewControllerContextTransitioning) -> Void
typealias HandleUpdateClosure = (InteractiveAnimator, AnyObject) -> Void

struct CustomTransitionConfiguration {
	let isInteractive: Bool
	let duration: TimeInterval
	let animateTransition: AnimateTransition
	let interactiveTransitionStarter: InteractiveTransitionStarter?
	let handleUpdateClosure: HandleUpdateClosure?
}
