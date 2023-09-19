//
//  TopController.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 19/09/23.
//

import UIKit

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.connectedScenes
                                    .filter { $0.activationState == .foregroundActive }
                                    .map { $0 as? UIWindowScene }
                                    .compactMap { $0 }
                                    .first?.windows
                                    .filter { $0.isKeyWindow }
                                    .first?.rootViewController) -> UIViewController {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base ?? UIViewController()
    }
}
