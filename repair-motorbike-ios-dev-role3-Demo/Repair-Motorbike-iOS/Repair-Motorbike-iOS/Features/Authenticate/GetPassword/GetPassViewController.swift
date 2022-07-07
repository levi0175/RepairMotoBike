//  
//  GetPassViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 28/04/2022.
//

import UIKit

final class GetPassViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var phoneTextbox: UITextbox!
    // MARK: - Variables
    private var model: GetPassContract.Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tappedHideKeyboard()
        setupUI()
    }
}

// MARK: - Setup UI
extension GetPassViewController {
    private func setupUI() {
        setupTextbox()
    }
    
    private func setupTextbox() {
        phoneTextbox.title = "Số điện thoại"
        phoneTextbox.placeholder = "Điền số điện thoại"
    }
}

// MARK: - Handle Action
extension GetPassViewController {
    @IBAction private func tapButtonSend(_ sender: UIButton) {
        let phone = phoneTextbox.contentTextField.text
        if phone?.isEmpty == true {
            self.showAlert(title: "Thông báo", message: "Mời nhập số điện thoại")
        } else if phone?.count != 10 {
            self.showAlert(title: "Thông báo", message: "Số điện thoại không đúng định dạng")
            return self.refreshAppGoToAuthenticate()
        }
    }
    
    @IBAction private func tapButtonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension GetPassViewController: GetPassControllerProtocol {
    func set(model: GetPassContract.Model) {
        self.model = model
    }
}
