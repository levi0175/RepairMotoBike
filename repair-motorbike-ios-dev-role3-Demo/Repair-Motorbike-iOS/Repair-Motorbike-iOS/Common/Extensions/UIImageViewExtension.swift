//
//  UIImageViewExtension.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit

extension UIImageView {
    
    func load(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    func roundCornersImage(_ corners: UIRectCorner, radius: CGFloat) {
     let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
     let mask = CAShapeLayer()
     mask.path = path.cgPath
     self.layer.mask = mask
   }
}
