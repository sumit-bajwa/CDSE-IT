//
//  ActivityIndicator.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 18/09/23.
//

import UIKit

class CustomActivityIndicatorView: UIActivityIndicatorView {
    

    init(style: UIActivityIndicatorView.Style = .large, color: UIColor = .gray) {
        super.init(style: style)
        self.color = color
        self.hidesWhenStopped = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating(on view: UIView) {
        center = view.center
        view.addSubview(self)
        self.startAnimating()
    }
    
     func stopAnimatingg() {
        self.stopAnimating()
        self.removeFromSuperview()
    }
}

extension UIViewController {
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.window?.windowScene?.screen.bounds.width ?? 0, height: self.view.window?.windowScene?.screen.bounds.height ?? 0))
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()

        activityIndicator.tag = 100 // 100 for example

        // before adding it, you need to check if it is already has been added:
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }

        view.addSubview(activityIndicator)
    }

    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()

        // I think you forgot to remove it?
        activityIndicator?.removeFromSuperview()

        //UIApplication.shared.endIgnoringInteractionEvents()
    }
}
