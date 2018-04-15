//
//  ViewController.swift
//  LunaPresentationTransition_example
//
//  Created by lunner on 2018/4/14.
//

import UIKit

class PresentingViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func doTransition(_ sender: Any) {
		let presentedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PresentedViewController")
		let presentTransitionConfiguration = CustomTransitionConfiguration(isInteractive: false, duration: 2, animateTransition: TransitionAnimationHelper.presentAnimator()!, interactiveTransitionStarter: nil, handleUpdateClosure: nil)
		let dismissTransitionConfiguration = CustomTransitionConfiguration(isInteractive: false, duration: 2, animateTransition: TransitionAnimationHelper.dismissAnimator()!, interactiveTransitionStarter: nil, handleUpdateClosure: nil)
		let presentationConfiguration = CustomPresentationConfiguration(initialization: TransitionAnimationHelper.presentationInitialization(), presentationWillBegin: TransitionAnimationHelper.presentationWillBegin(), presentationDidEnd: TransitionAnimationHelper.presentationDidEnd(), dismissalWillbegin: TransitionAnimationHelper.dismissalWillBegin(), dismissalDidEnd: TransitionAnimationHelper.dismissalDidEnd())
		let transitionDelegate = ViewControllerTransitioningDelegate(presentTransitionConfiguration: presentTransitionConfiguration, dismissTransitionConfiguration: dismissTransitionConfiguration, presentationConfiguration: presentationConfiguration)
		presentedViewController.transitioningDelegate = transitionDelegate
		presentedViewController.modalPresentationStyle = .custom
		self.present(presentedViewController, animated: true, completion: nil)
		
	}
	
}

