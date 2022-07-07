//
//  UITabViewCommon.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 10/05/2022.
//

import UIKit
protocol delegateTabViewHome: AnyObject {
    func handleChangeTabView(with type: UITabViewCommon.TypeTab)
}
final class UITabViewCommon: UIView {
    // MARK: - Enum
    enum StypeTab {
        case small
        case regular
        
        var action: UIColor? {
            switch self {
            case .small:
                return AppColor.View.Red
            case .regular:
                return AppColor.View.Red
            }
        }
        var inaction: UIColor? {
            switch self {
            case .small:
                return .black
            case .regular:
                return .black
            }
        }
    }
    enum TypeTab {
        case left
        case bottom
        case right
    }
    // MARK: - IBOutlet
    @IBOutlet private weak var contrainSlide: NSLayoutConstraint!
    @IBOutlet private weak var slideView: UIView!
    @IBOutlet private weak var leftButon: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet private weak var contentView: UIView!
    // MARK: - Public Variables
    weak var delegate: delegateTabViewHome?
    lazy var style: StypeTab = .regular
    lazy var type: TypeTab = .left {
        willSet {
                if newValue == .left {
                    leftButon.setTitleColor(style.inaction, for: .normal)
                    bottomButton.setTitleColor(style.action, for: .normal)
                    rightButton.setTitleColor(style.inaction, for: .normal)
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.contrainSlide = self?.contrainSlide.setMultiplier(multiplier: 1)
                    self?.layoutIfNeeded()
                },
                    completion: { _ in
                    self.slideView.layer.removeAllAnimations()
                })
            }
            if newValue == .bottom {
                leftButon.setTitleColor(style.inaction, for: .normal)
                bottomButton.setTitleColor(style.inaction, for: .normal)
                rightButton.setTitleColor(style.action, for: .normal)
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.contrainSlide = self?.contrainSlide.setMultiplier(multiplier: 5 / 3)
                    self?.layoutIfNeeded()
                    self?.layoutIfNeeded()
                },
                    completion: { _ in
                    self.slideView.layer.removeAllAnimations()
                })
            }
            if newValue == .right {
                leftButon.setTitleColor(style.action, for: .normal)
                bottomButton.setTitleColor(style.inaction, for: .normal)
                rightButton.setTitleColor(style.inaction, for: .normal)
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.contrainSlide = self?.contrainSlide.setMultiplier(multiplier: 1 / 3)
                    self?.layoutIfNeeded()
                    self?.layoutIfNeeded()
                },
                    completion: { _ in
                    self.slideView.layer.removeAllAnimations()
                    
                })
            }
        }
    }
    lazy var textLeft: String? = nil {
        willSet {
          //  leftButon.setTitleColor(style.inaction, for: .normal)
            leftButon.setTitle(newValue, for: .normal)
        }
    }
    lazy var textBottom: String? = nil {
        willSet {
           // bottomButton.setTitleColor(style.inaction, for: .normal)
            bottomButton.setTitle(newValue, for: .normal)
        }
    }
    lazy var textRight: String? = nil {
        willSet {
           // rightButton.setTitleColor(style.action, for: .normal)
            rightButton.setTitle(newValue, for: .normal)
        }
    }
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
        setupBottom()
    }
    private func setupBottom() {
        leftButon.setTitleColor(AppColor.Label.TitleLabel, for: .normal)
        bottomButton.setTitleColor(AppColor.Label.TitleLabel, for: .normal)
        rightButton.setTitleColor(AppColor.Label.TitleLabel, for: .normal)
        leftButon.titleLabel?.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoRegular.rawValue)
        bottomButton.titleLabel?.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoRegular.rawValue)
        rightButton.titleLabel?.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoRegular.rawValue)
    }
    private func setupView() {
        slideView.backgroundColor = AppColor.View.Red
    }
}
// MARK: - handle Action
extension UITabViewCommon {
    @IBAction func tabBottomButon(_ sender: Any) {
        delegate?.handleChangeTabView(with: .left)
    }
    @IBAction func tabRightButon(_ sender: Any) {
        delegate?.handleChangeTabView(with: .bottom)
    }
    @IBAction func tabLeftButon(_ sender: Any) {
        delegate?.handleChangeTabView(with: .right)
    }
}
extension NSLayoutConstraint {
    func setMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        guard let firstItem = firstItem else {
            return self
        }
        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(item: firstItem, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
