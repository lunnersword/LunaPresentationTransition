//
//  PresentationController.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/14.
//

import UIKit


typealias PresentationInitialization = (_ presentedViewController: UIViewController , _ presentingViewController: UIViewController?, _ presentationController: PresentationController) -> Void
typealias PresentationTransitionWillBeginClosure = (_ presentationController: PresentationController) -> Void
typealias PresentationTransitionDidEndClosure = (_ presentationController: PresentationController, _ completed: Bool) -> Void
typealias DismissalTransitionWillBeginClosure = (_ presentationController: PresentationController) -> Void
typealias DismissalTransitionDidEndClosure = (_ presentationController: PresentationController, _ completed: Bool) -> Void
typealias FrameOfPresentedViewInContainerViewClosure = (_ presentationController: PresentationController) -> CGRect

struct CustomPresentationConfiguration {
	//
	
	let presentationInitialization: PresentationInitialization?
	let presentationTransitionWillBeginClosure: PresentationTransitionWillBeginClosure?
	let presentationTransitionDidEndClosure: PresentationTransitionDidEndClosure?
	let dismissalTransitionWillBeginClosure: DismissalTransitionWillBeginClosure?
	let dismissalTransitionDidEndClosure: DismissalTransitionDidEndClosure?
	let frameOfPresentedViewInContainerViewClosure: FrameOfPresentedViewInContainerViewClosure?
}

class PresentationController: UIPresentationController, UIViewControllerTransitioningDelegate {
	var configuration: CustomPresentationConfiguration?
	var presentationDictionary: [String: Any] = [:]
	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
		super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
	}
	
	convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, configuration presentationConfiguration: CustomPresentationConfiguration) {
		self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		configuration = presentationConfiguration
		if let initialization = configuration?.presentationInitialization {
			initialization(presentedViewController, presentingViewController, self)
		}
	}
	
	override func presentationTransitionWillBegin() {
		if let transitionWillBegin = configuration?.presentationTransitionWillBeginClosure {
			transitionWillBegin(self)
		}
	}
	
	override func presentationTransitionDidEnd(_ completed: Bool) {
		if let transitionDidEnd = configuration?.presentationTransitionDidEndClosure {
			transitionDidEnd(self, completed)
		}
	}
	
	override func dismissalTransitionWillBegin() {
		if let dismissalWillBegin = configuration?.dismissalTransitionWillBeginClosure {
			dismissalWillBegin(self)
		}
	}
	
	override func dismissalTransitionDidEnd(_ completed: Bool) {
		if let dismissalDidEnd = configuration?.dismissalTransitionDidEndClosure {
			dismissalDidEnd(self, completed)
		}
	}
	
}

