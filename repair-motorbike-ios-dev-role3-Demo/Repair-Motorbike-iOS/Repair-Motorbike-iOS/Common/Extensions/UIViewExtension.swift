//
//  UIViewExtension.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit

extension UIView {
   
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func addSubViewAutoresizing(_ view: UIView) {
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "\(Self.self)",
                        bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        return view
    }
    
    func setShadow(color: UIColor? = .gray,
                   opacity: Float = 1,
                   radius: CGFloat = 4,
                   offset: CGSize = CGSize(width: 0, height: 0)) {
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = opacity
    }
    
    func dropShadowWithCornerRaduis(corlor: UIColor) {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = corlor
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2.5
        layer.masksToBounds = false
    }
    
    func setBorder(color: UIColor? = .gray,
                   width: CGFloat = 1) {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
    }
    
    // set border bottom View
    func addBorder(side: EnumConstant.BorderSide, color: UIColor, width: CGFloat) {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = color
        self.addSubview(border)
        
        let topConstraint = topAnchor.constraint(equalTo: border.topAnchor)
        let rightConstraint = trailingAnchor.constraint(equalTo: border.trailingAnchor)
        let bottomConstraint = bottomAnchor.constraint(equalTo: border.bottomAnchor)
        let leftConstraint = leadingAnchor.constraint(equalTo: border.leadingAnchor)
        let heightConstraint = border.heightAnchor.constraint(equalToConstant: width)
        let widthConstraint = border.widthAnchor.constraint(equalToConstant: width)
        
        switch side {
        case .top:
            NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, heightConstraint])
        case .right:
            NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, widthConstraint])
        case .bottom:
            NSLayoutConstraint.activate([rightConstraint, bottomConstraint, leftConstraint, heightConstraint])
        case .left:
            NSLayoutConstraint.activate([bottomConstraint, leftConstraint, topConstraint, widthConstraint])
        }
    }
    func dropShadowView(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    private static let kLayerNameGradientBorder = "GradientBorderLayer"
    
    func gradientBorder(width: CGFloat,
                        colors: [UIColor],
                        startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
                        endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
                        corners: UIRectCorner,
                        andRoundCornersWithRadius cornerRadius: CGFloat = 0) {
        
        let existingBorder = gradientBorderLayer()
        let border = existingBorder ?? CAGradientLayer()
        border.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y,
                              width: bounds.size.width + width, height: bounds.size.height + width)
        border.colors = colors.map {
            $0.cgColor
        }
        border.startPoint = startPoint
        border.endPoint = endPoint
        
        let mask = CAShapeLayer()
        let maskRect = CGRect(x: bounds.origin.x + width / 2, y: bounds.origin.y + width / 2,
                              width: bounds.size.width - width, height: bounds.size.height - width)
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = width
        let path1 = UIBezierPath(roundedRect: maskRect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        mask.path = path1.cgPath
        border.mask = mask
        
        let exists = (existingBorder != nil)
        if !exists {
            layer.addSublayer(border)
        }
    }
    private func gradientBorderLayer() -> CAGradientLayer? {
        let borderLayers = layer.sublayers?.filter {
            $0.name == UIView.kLayerNameGradientBorder
        }
        if borderLayers?.count ?? 0 > 1 {
            fatalError("error")
        }
        return borderLayers?.first as? CAGradientLayer
    }
    func roundCornersUIView(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    @discardableResult
    func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    func setRightTriangle(targetView: UIView?) {
        let heightWidth = targetView!.frame.size.width // you can use triangleView.frame.size.height
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: heightWidth / 2, y: 0))
        path.addLine(to: CGPoint(x: heightWidth, y: heightWidth / 2))
        path.addLine(to: CGPoint(x: heightWidth / 2, y: heightWidth))
        path.addLine(to: CGPoint(x: heightWidth / 2, y: 0))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.red.cgColor
        
        targetView!.layer.insertSublayer(shape, at: 0)
    }
    
    func setLeftTriangle(targetView: UIView?) {
        let heightWidth = targetView!.frame.size.height / 2
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: heightWidth / 2, y: 0))
        path.addLine(to: CGPoint(x: 0, y: heightWidth / 2))
        path.addLine(to: CGPoint(x: heightWidth / 2, y: heightWidth))
        path.addLine(to: CGPoint(x: heightWidth / 2, y: 0))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.red.cgColor
        
        targetView!.layer.insertSublayer(shape, at: 0)
    }
    
    func setUpTriangle(targetView: UIView?) {
        let heightWidth = targetView!.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x: heightWidth / 2, y: heightWidth / 2))
        path.addLine(to: CGPoint(x: heightWidth, y: heightWidth))
        path.addLine(to: CGPoint(x: 0, y: heightWidth))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.red.cgColor
        
        targetView!.layer.insertSublayer(shape, at: 0)
    }
    
    func setDownTriangle(targetView: UIView?) {
        let heightWidth = targetView!.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: heightWidth / 2, y: heightWidth / 2))
        path.addLine(to: CGPoint(x: heightWidth, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.red.cgColor
        
        targetView!.layer.insertSublayer(shape, at: 0)
    }
       func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    
}
