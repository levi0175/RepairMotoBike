//
//  UILogoView.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit

final class UILogoView: UIView {
    // MARK: - IBOutlet
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var logoImageView: UIImageView!

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

    private func setupView() {
        backgroundView.backgroundColor = AppColor.View.Background
        logoImageView.image = UIImage(named: AppImage.Image.repair)
    }
}

// MARK: - Public Handle Action
extension UILogoView {
    func startLogoViewAnimation(at view: UIView) {
        view.addSubViewAutoresizing(self)
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .beginFromCurrentState,
                       animations: { [weak self] in
            self?.alpha = 0
        },
                       completion: { _ in
            self.layer.removeAllAnimations()
            self.removeFromSuperview()
        })
    }
}
