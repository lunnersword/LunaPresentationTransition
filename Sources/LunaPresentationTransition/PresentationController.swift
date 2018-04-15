//
//  PresentationController.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/14.
//

import UIKit


typealias PresentationInitialization = (UIViewController , UIViewController?, PresentationController) -> Void
typealias PresentationTransitionWillBeginClosure = (PresentationController) -> Void
typealias PresentationTransitionDidEndClosure = (PresentationController, Bool) -> Void
typealias DismissalTransitionWillBeginClosure = (PresentationController) -> Void
typealias DismissalTransitionDidEndClosure = (PresentationController, Bool) -> Void
typealias FrameOfPresentedViewInContainerViewClosure = (PresentationController) -> CGRect
typealias ContainerViewWillLayoutSubviewsClosure = (PresentationController) -> Void
typealias ContainerViewDidLayoutSubviewsClosure = (PresentationController) -> Void
struct CustomPresentationConfiguration {
	//
	let showPresentInFullScreen: Bool
	let initialization: PresentationInitialization?
	let presentationWillBegin: PresentationTransitionWillBeginClosure?
	let presentationDidEnd: PresentationTransitionDidEndClosure?
	let dismissalWillBegin: DismissalTransitionWillBeginClosure?
	let dismissalDidEnd: DismissalTransitionDidEndClosure?
	let frameOfPresentedViewInContainerView: FrameOfPresentedViewInContainerViewClosure?
	let containerViewWillLayoutSubviews: ContainerViewWillLayoutSubviewsClosure?
	let containerViewDidLayoutSubviews: ContainerViewDidLayoutSubviewsClosure?
	
	init(initialization: PresentationInitialization?, presentationWillBegin: PresentationTransitionWillBeginClosure?, presentationDidEnd: PresentationTransitionDidEndClosure?, dismissalWillbegin: DismissalTransitionWillBeginClosure?, dismissalDidEnd: DismissalTransitionDidEndClosure?) {
		self.init(initialization: initialization, presentationWillBegin: presentationWillBegin, presentationDidEnd: presentationDidEnd, dismissalWillbegin: dismissalWillbegin, dismissalDidEnd: dismissalDidEnd, frameOfPresentedViewInContainerView: nil, containerViewWillLayoutSubviews: nil, containerViewDidLayoutSubviews: nil, inFullScreen: true)
	}
	
	init(initialization: PresentationInitialization?, presentationWillBegin: PresentationTransitionWillBeginClosure?, presentationDidEnd: PresentationTransitionDidEndClosure?, dismissalWillbegin: DismissalTransitionWillBeginClosure?, dismissalDidEnd: DismissalTransitionDidEndClosure?, frameOfPresentedViewInContainerView: FrameOfPresentedViewInContainerViewClosure?, containerViewWillLayoutSubviews: ContainerViewWillLayoutSubviewsClosure?, containerViewDidLayoutSubviews: ContainerViewDidLayoutSubviewsClosure?, inFullScreen: Bool) {
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

class PresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {
	var configuration: CustomPresentationConfiguration?
	var presentationDictionary: [String: Any] = [:]
	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
		super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
	}
	
	convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, configuration presentationConfiguration: CustomPresentationConfiguration) {
		self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		configuration = presentationConfiguration
		if let initialization = configuration?.initialization {
			initialization(presentedViewController, presentingViewController, self)
		}
	}
	
	override func presentationTransitionWillBegin() {
		if let transitionWillBegin = configuration?.presentationWillBegin {
			transitionWillBegin(self)
		}
	}
	
	override func presentationTransitionDidEnd(_ completed: Bool) {
		if let transitionDidEnd = configuration?.presentationDidEnd {
			transitionDidEnd(self, completed)
		}
	}
	
	override func dismissalTransitionWillBegin() {
		if let dismissalWillBegin = configuration?.dismissalWillBegin {
			dismissalWillBegin(self)
		}
	}
	
	override func dismissalTransitionDidEnd(_ completed: Bool) {
		if let dismissalDidEnd = configuration?.dismissalDidEnd {
			dismissalDidEnd(self, completed)
		}
	}
	
	override var frameOfPresentedViewInContainerView: CGRect {
		if let frame = configuration?.frameOfPresentedViewInContainerView {
			return frame(self)
		} else {
			return super.frameOfPresentedViewInContainerView
		}
	}
	
	override var shouldPresentInFullscreen: Bool {
		if let should = configuration?.showPresentInFullScreen {
			return should
		} else {
			return super.shouldPresentInFullscreen
		}
	}
	override func containerViewWillLayoutSubviews() {
		if let willLayout = configuration?.containerViewWillLayoutSubviews{
			willLayout(self)
		}
	}
	
	override func containerViewDidLayoutSubviews() {
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

