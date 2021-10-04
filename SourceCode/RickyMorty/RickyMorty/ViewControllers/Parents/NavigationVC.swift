//
//  NavigationVC.swift
//  RickyMorty
//

import UIKit

//MARK: - class NavigationVC
class NavigationVC: UINavigationController {
}

//MARK: UIViewController Method(s)
extension NavigationVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareObjects()
    }
    
}

//MARK: UIRelated
extension NavigationVC {
    
    private func prepareObjects() {
        weak var weakSelf: NavigationVC? = self
        interactivePopGestureRecognizer?.delegate = weakSelf!
        delegate = weakSelf!
        isNavigationBarHidden = true
    }
}

//MARK: UIGestureRecognizerDelegate
extension NavigationVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count > 1 {
            return true
        }else{
            return false
        }
    }
}

//MARK: UINavigationControllerDelegate
extension NavigationVC: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer!.isEnabled = (viewController is TabBarVC == false)
    }
}
