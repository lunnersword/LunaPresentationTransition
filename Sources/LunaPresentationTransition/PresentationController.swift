//
//  PresentationController.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/14.
//

import UIKit


public typealias PresentationInitialization = (UIViewController , UIViewController?, PresentationController) -> Void
public typealias PresentationTransitionWillBeginClosure = (PresentationController) -> Void
public typealias PresentationTransitionDidEndClosure = (PresentationController, Bool) -> Void
public typealias DismissalTransitionWillBeginClosure = (PresentationController) -> Void
public typealias DismissalTransitionDidEndClosure = (PresentationController, Bool) -> Void
public typealias FrameOfPresentedViewInContainerViewClosure = (PresentationController) -> CGRect
public typealias ContainerViewWillLayoutSubviewsClosure = (PresentationController) -> Void
public typealias ContainerViewDidLayoutSubviewsClosure = (PresentationController) -> Void
public struct CustomPresentationConfiguration {
	//
	let showPresentInFullScreen: Bool
	var initialization: PresentationInitialization?
	var presentationWillBegin: PresentationTransitionWillBeginClosure?
	var presentationDidEnd: PresentationTransitionDidEndClosure?
	var dismissalWillBegin: DismissalTransitionWillBeginClosure?
	var dismissalDidEnd: DismissalTransitionDidEndClosure?
	var frameOfPresentedViewInContainerView: FrameOfPresentedViewInContainerViewClosure?
	var containerViewWillLayoutSubviews: ContainerViewWillLayoutSubviewsClosure?
	var containerViewDidLayoutSubviews: ContainerViewDidLayoutSubviewsClosure?
	
	public init(initialization: PresentationInitialization?, presentationWillBegin: PresentationTransitionWillBeginClosure?, presentationDidEnd: PresentationTransitionDidEndClosure?, dismissalWillbegin: DismissalTransitionWillBeginClosure?, dismissalDidEnd: DismissalTransitionDidEndClosure?) {
		self.init(initialization: initialization, presentationWillBegin: presentationWillBegin, presentationDidEnd: presentationDidEnd, dismissalWillbegin: dismissalWillbegin, dismissalDidEnd: dismissalDidEnd, frameOfPresentedViewInContainerView: nil, containerViewWillLayoutSubviews: nil, containerViewDidLayoutSubviews: nil, inFullScreen: true)
	}
	
	public init(initialization: PresentationInitialization?, presentationWillBegin: PresentationTransitionWillBeginClosure?, presentationDidEnd: PresentationTransitionDidEndClosure?, dismissalWillbegin: DismissalTransitionWillBeginClosure?, dismissalDidEnd: DismissalTransitionDidEndClosure?, frameOfPresentedViewInContainerView: FrameOfPresentedViewInContainerViewClosure?, containerViewWillLayoutSubviews: ContainerViewWillLayoutSubviewsClosure?, containerViewDidLayoutSubviews: ContainerViewDidLayoutSubviewsClosure?, inFullScreen: Bool) {
		self.initialization = initialization
		self.presentationWillBegin = presentationWillBegin
		self.presentationDidEnd = presentationDidEnd
		self.dismissalWillBegin = dismissalWillbegin
		self.dismissalDidEnd = dismissalDidEnd
		self.frameOfPresentedViewInContainerView = frameOfPresentedViewInContainerView
		self.containerViewDidLayoutSubviews = containerViewWillLayoutSubviews
		self.containerViewWillLayoutSubviews = containerViewDidLayoutSubviews
		self.showPresentInFullScreen = inFullScreen
	}
}

public class PresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {
	var configuration: CustomPresentationConfiguration?
	var presentationDictionary: [String: Any] = [:]
//	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
//		super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
//	}
	
	convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, configuration presentationConfiguration: CustomPresentationConfiguration) {
		self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		configuration = presentationConfiguration
		if let initialization = configuration?.initialization {
			initialization(presentedViewController, presentingViewController, self)
		}
	}
	
	override public func presentationTransitionWillBegin() {
		if let transitionWillBegin = configuration?.presentationWillBegin {
			transitionWillBegin(self)
		}
	}
	
	override public func presentationTransitionDidEnd(_ completed: Bool) {
		if let transitionDidEnd = configuration?.presentationDidEnd {
			transitionDidEnd(self, completed)
		}
	}
	
	override public func dismissalTransitionWillBegin() {
		if let dismissalWillBegin = configuration?.dismissalWillBegin {
			dismissalWillBegin(self)
		}
	}
	
	override public func dismissalTransitionDidEnd(_ completed: Bool) {
		if let dismissalDidEnd = configuration?.dismissalDidEnd {
			dismissalDidEnd(self, completed)
		}
	}
	
	override public var frameOfPresentedViewInContainerView: CGRect {
		if let frame = configuration?.frameOfPresentedViewInContainerView {
			return frame(self)
		} else {
			return super.frameOfPresentedViewInContainerView
		}
	}
	
	override public var shouldPresentInFullscreen: Bool {
		if let should = configuration?.showPresentInFullScreen {
			return should
		} else {
			return super.shouldPresentInFullscreen
		}
	}
	override public func containerViewWillLayoutSubviews() {
		if let willLayout = configuration?.containerViewWillLayoutSubviews{
			willLayout(self)
		}
	}
	
	override public func containerViewDidLayoutSubviews() {
		if let didLayout = configuration?.containerViewDidLayoutSubviews {
			didLayout(self)
		}
	}
	
	// MARK: - animation for dissmissed not work in UIViewControllerTransitionDelegate
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		if let transitionDelegate = dismissed.transitioningDelegate as? ViewControllerTransitioningDelegate {
			if let dismissConfiguration = transitionDelegate.dismissTransitionConfiguration, !dismissConfiguration.isInteractive {
				return Animator(dismissConfiguration)
			}

		}
		return nil
	}

}

