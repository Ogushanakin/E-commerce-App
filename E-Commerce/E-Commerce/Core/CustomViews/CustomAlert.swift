//
//  CustomAlert.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 26.07.2024.
//

import UIKit

final class Alert {
    
    static func alertMessage(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
}
