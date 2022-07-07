//
//  HideKeyBoardExtention.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 14/05/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func tappedHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
