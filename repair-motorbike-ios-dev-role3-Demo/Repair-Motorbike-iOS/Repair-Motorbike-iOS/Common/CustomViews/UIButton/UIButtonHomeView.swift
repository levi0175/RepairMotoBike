//
//  UIButtonHomeView.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 08/05/2022.
//

import UIKit

final class UIButtonHomeView: UIView {
    // MARK: - IBOutlet
    @IBOutlet private weak var imageVIew: UIImageView!
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private override init(frame: CGRect) {
       super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
     super.init(coder: coder)
        setupUI()
    }
    lazy var textLabel: String? = nil {
        willSet {
            titleLabel.text = newValue
        }
    }
    lazy var imageView: UIImage? = nil {
        willSet {
            imageVIew.image = newValue
        }
    }
    // MARK: - Setup UI
    private func setupUI() {
        addSubViewAutoresizing(loadViewFromNib())
        setupView()
    }

    func setupView() {
      //  containView.layer.cornerRadius = 8
        titleLabel.setSizeFont(sizeFont: 27)
        containView.dropShadowWithCornerRaduis(corlor: UIColor.white)
        containView.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
     //   containView.dropShadowWithCornerRaduis(corlor: .red)
       // containView.setBorder(color: .red, width: 0.05)
        imageVIew.image = UIImage(named: AppImage.Image.Booking)
    }
}

// MARK: - Public Handle Action
extension UIButtonHomeView {
    func getButtomHome(at view: UIView) {
        view.addSubViewAutoresizing(self)
    }
}
