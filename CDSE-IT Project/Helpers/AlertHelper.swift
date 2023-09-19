//
//  AlertHelper.swift
//  Megamine Creations
//
//  Created by SUMIT on 16/09/23.
//

import UIKit

class AlertHelper {
    static func showAlert(in viewController: UIViewController,title: String = "Alert", message: String,okActionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okActionHandler))
        viewController.present(alert, animated: true)
    }
    
    static func handleDeniedCameraPermission(in viewController: UIViewController) {
        let alertController = UIAlertController(
            title: "Camera Access Denied",
            message: "Please enable camera access in Settings to use this feature.",
            preferredStyle: .alert
        )

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func handleDeniedMicrophonePermission(in viewController: UIViewController) {
        let alertController = UIAlertController(
            title: "Microphone Access Denied",
            message: "Please enable microphone access in Settings to use this feature.",
            preferredStyle: .alert
        )

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
}

