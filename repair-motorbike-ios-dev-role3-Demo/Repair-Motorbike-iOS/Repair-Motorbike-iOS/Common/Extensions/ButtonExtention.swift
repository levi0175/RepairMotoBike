//
//  ButtonExtention.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 29/04/2022.
//

import UIKit
extension UIButton {
    func setWidthButton() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.red.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
