//
//  UITextbox.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 24/05/2022.
//

import UIKit

protocol DelegateTextbox: AnyObject {
    func textboxDidBeginEditting(_ textbox: UITextbox)
    func textboxDidEndEditting(_ textbox: UITextbox)
}

final class UITextbox: UIView {
    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet private weak var lineView: UIView!
        
    weak var delegate: DelegateTextbox?
    lazy var title: String = "" {
        willSet {
            titleLabel.text = newValue
        }
    }
    
    lazy var placeholder: String = "" {
        willSet {
            contentTextField.placeholder = newValue
        }
    }
    
    lazy var text: String = "" {
        willSet {
            contentTextField.text = newValue
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
    }
    func hideTitle() {
        titleLabel.isHidden = true
    }
    private func setupView() {
        contentTextField.delegate = self
        titleLabel.textColor = .black
        titleLabel.font = AppFont.T12.Medium
        contentTextField.textColor = .black
        contentTextField.font = AppFont.T12.Medium
        lineView.backgroundColor = .lightGray
    }
    func borderView() {
        contentTextField.layer.cornerRadius = 15
    }
    func setupSecure() {
        contentTextField.isSecureTextEntry = true
    }
}

extension UITextbox: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textboxDidBeginEditting(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textboxDidEndEditting(self)
    }
}
