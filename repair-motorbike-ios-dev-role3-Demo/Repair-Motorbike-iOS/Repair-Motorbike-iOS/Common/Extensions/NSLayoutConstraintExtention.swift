//
//  NSLayoutConstraintExtention.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 14/05/2022.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
