//
//  UIButtonBorder.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 10/05/2022.
//

import UIKit
final class UIButtonBorder: UIView {
    // MARK: - IBOutlet
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!
    
    private override init(frame: CGRect) {
       super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
     super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        addSubViewAutoresizing(loadViewFromNib())
        setupView()
    }
    lazy var textLbl: String? = nil {
        willSet {
            textLabel.text = newValue
        }
    }
    lazy var imageButton: UIImage? = nil {
        willSet {
            imageView.image = newValue
        }
    }
    func setupView() {
      //  contentView.layer.cornerRadius = 10
        textLabel.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width / 32)
        contentView.layer.cornerRadius = 5
        contentView.setBorder(color: AppColor.View.Red, width: 0.6)
       // contentView.dropShadowWithCornerRaduis(corlor: .red)
        
    }
}

// MARK: - Public Handle Action
extension UIButtonBorder {
    func getButtonBorder(at view: UIView) {
        view.addSubViewAutoresizing(self)
    }
}
