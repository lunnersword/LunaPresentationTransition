//
//  CustomTransitionConfiguration.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/14.
//
import UIKit

public typealias AnimateTransition = (Animator, UIViewControllerContextTransitioning) -> Void
public typealias InteractiveTransitionStarter = (InteractiveAnimator, UIViewControllerContextTransitioning) -> Void
public typealias HandleUpdateClosure = (InteractiveAnimator, AnyObject) -> Void

public struct CustomTransitionConfiguration {
	public var isInteractive: Bool
	public var duration: TimeInterval
	public var animateTransition: AnimateTransition
	public var interactiveTransitionStarter: InteractiveTransitionStarter?
	public var handleUpdateClosure: HandleUpdateClosure?
}
