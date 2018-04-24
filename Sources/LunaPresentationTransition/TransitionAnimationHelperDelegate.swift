//
//  TransitionAnimationHelperDelegate.swift
//  LunaPresentationTransition
//
//  Created by lunner on 2018/4/15.
//

import Foundation
import UIKit
public protocol TransitionAnimationHelperDelegate {
	static func presentAnimator() -> AnimateTransition?
	static func dismissAnimator() -> AnimateTransition?
	
	// MARK: - Presentation Handlers
	static func presentationInitialization() -> PresentationInitialization?
	static func presentationWillBegin() -> PresentationTransitionWillBeginClosure?
	static func presentationDidEnd() -> PresentationTransitionDidEndClosure?
	static func dismissalWillBegin() -> DismissalTransitionWillBeginClosure?
	static func dismissalDidEnd() -> DismissalTransitionDidEndClosure?
	
}
