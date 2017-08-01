//
//  Copyright © 2017 Square, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

/// Displays modal view controller as a full height sheet with a faded background
final class SheetPresentationController: UIPresentationController {
    private lazy var dimmingView: UIView = self.makeDimmingView()
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView, let transitionCoordinator = presentedViewController.transitionCoordinator else {
                return
        }
        dimmingView.frame = containerView.bounds
        containerView.addSubview(dimmingView)
        
        transitionCoordinator.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentedViewController.transitionCoordinator
        
        transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        }, completion: { _ in
            self.dimmingView.removeFromSuperview()
        })
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerViewBounds = super.frameOfPresentedViewInContainerView
        let horizontalInsetAmount = containerViewBounds.width / 8
        return containerViewBounds.insetBy(dx: horizontalInsetAmount, dy: 0.0)
    }
    
    private func makeDimmingView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        view.alpha = 0.0
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        view.addGestureRecognizer(tapToDismiss)
        return view
    }
    
    @objc private func dismiss() {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
