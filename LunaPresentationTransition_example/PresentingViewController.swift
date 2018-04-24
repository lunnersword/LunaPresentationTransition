//
//  ViewController.swift
//  LunaPresentationTransition_example
//
//  Created by lunner on 2018/4/14.
//

import UIKit

class PresentingViewController: UIViewController {
	var delegate: ViewControllerTransitioningDelegate?
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func doTransition(_ sender: Any) {
//		let viewClass = NSClassFromString("LunaPresentationTransition_example.NibViewController") as! UIViewController.Type
//		let viewString = NSStringFromClass(viewClass)
//		let names = viewString.components(separatedBy: ".")
//		let viewc = viewClass.init(nibName: names[1], bundle:nil)
//		self.present(viewc, animated: true, completion: nil)
//		return
		
		let presentedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"PresentedViewController")
		let presentTransitionConfiguration = CustomTransitionConfiguration(isInteractive: false, duration: 2, animateTransition: TransitionAnimationHelper.presentAnimator()!, interactiveTransitionStarter: nil, handleUpdateClosure: nil)
		let dismissTransitionConfiguration = CustomTransitionConfiguration(isInteractive: false, duration: 2, animateTransition: TransitionAnimationHelper.dismissAnimator()!, interactiveTransitionStarter: nil, handleUpdateClosure: nil)
		let presentationConfiguration = CustomPresentationConfiguration(initialization: TransitionAnimationHelper.presentationInitialization(), presentationWillBegin: TransitionAnimationHelper.presentationWillBegin(), presentationDidEnd: TransitionAnimationHelper.presentationDidEnd(), dismissalWillbegin: TransitionAnimationHelper.dismissalWillBegin(), dismissalDidEnd: TransitionAnimationHelper.dismissalDidEnd())
		let transitionDelegate = ViewControllerTransitioningDelegate(presentTransitionConfiguration: presentTransitionConfiguration, dismissTransitionConfiguration: dismissTransitionConfiguration, presentationConfiguration: presentationConfiguration)
		//https://stackoverflow.com/questions/34302830/ios-9-custom-transition-animationcontrollerfordismissedcontroller-not-called
		//the dismiss animation is not processed, if we fail to keep a strong reference to the delegate!
		self.delegate = transitionDelegate
		presentedViewController.transitioningDelegate = transitionDelegate
		presentedViewController.modalPresentationStyle = .custom
//		self.present(presentedViewController, animated: true, completion: nil)
		self.show(presentedViewController, sender: self)
		
	}
	
}

