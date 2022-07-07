//
//  TextFieldExtension.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 26/04/2022.
//

import UIKit
import Foundation

extension UITextField {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: layer.frame.height - 1, width: layer.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(bottomLine)
    }
}
enum UILabelTextPositions: String {
    case VERTICAL_ALIGNMENT_TOP = "VerticalAlignmentTop"
    case VERTICAL_ALIGNMENT_MIDDLE = "VerticalAlignmentMiddle"
    case VERTICAL_ALIGNMENT_BOTTOM = "VerticalAlignmentBottom"
    
}

extension UILabel {
    
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    public var padding: UIEdgeInsets? {
        get {
             objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else {
            return super.intrinsicContentSize }
        
        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        var insetsWidth: CGFloat = 0.0
        
        if let insets = padding {
            insetsWidth += insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
            textWidth -= insetsWidth
        }
        
        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)
        
        contentSize.height = ceil(newSize.size.height) + insetsHeight
        contentSize.width = ceil(newSize.size.width) + insetsWidth
        
        return contentSize
    }
    func setSizeFont1 (sizeFont: Double, font1: String) {
      //  self.font = UIFont(name: "Kailasa", size: UIScreen.main.bounds.width / sizeFont)
        self.font = UIFont(name: font1, size: UIScreen.main.bounds.width / sizeFont)
        self.sizeToFit()
    }
    func setSizeFont (sizeFont: Double) {
      //  self.font = UIFont(name: "Kailasa", size: UIScreen.main.bounds.width / sizeFont)
        self.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width / sizeFont)
    }
    func setMargins(_ margin: CGFloat = 10) {
           if let textString = self.text {
               let paragraphStyle = NSMutableParagraphStyle()
               paragraphStyle.firstLineHeadIndent = margin
               paragraphStyle.headIndent = margin
               paragraphStyle.tailIndent = -margin
               let attributedString = NSMutableAttributedString(string: textString)
               attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
               attributedText = attributedString
           }
       }
}
