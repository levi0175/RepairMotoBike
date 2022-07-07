//  
//  DetailSettingViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 05/05/2022.
//

import UIKit

final class DetailSettingViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    @IBOutlet private weak var oldPassTextbox: UITextbox!
    @IBOutlet private weak var newPassTextbox: UITextbox!
    @IBOutlet private weak var confirmTextbox: UITextbox!
    // MARK: - Variables
    private var model: DetailSettingContract.Model?
    var dataUser: SettingViewEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tappedHideKeyboard()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
}

// MARK: - Setup UI
extension DetailSettingViewController {
    private func setupUI() {
        setupNaviBar()
        setupTextbox()
    }
    
    private func setupNaviBar() {
        naviBar.tappedBack {
            self.navigationController?.popViewController(animated: true)
        }
        naviBar.tappedSave {
            let oldPass = self.oldPassTextbox.contentTextField.text

            let newPass = self.newPassTextbox.contentTextField.text

            let confirm = self.confirmTextbox.contentTextField.text
            if confirm != newPass {
                self.showAlert(title: "Thông báo", message: "Xác nhận lại mật khẩu mới!")
            }

            self.model?.changePass(id: self.dataUser?.data!.userId ?? 0, passwordSaved: oldPass!, newPassword: newPass!) { [weak self] result in
                switch result {
                case .success:
                    self?.showAlert(title: "Thông báo", message: "Thay đổi thành công!")
                case .failure(let error):
                    self?.showAlert(message: error)
                    print(error)
                }
            }
        }
        naviBar.configData(title: "Cập nhật mật khẩu")
    }
    private func setupTextbox() {
        oldPassTextbox.title = "Mật khẩu cũ:"
        oldPassTextbox.placeholder = "Điền mật khẩu cũ"
        newPassTextbox.title = "Mật khẩu mới:"
        newPassTextbox.placeholder = "Điền mật khẩu mới"
        confirmTextbox.title = "Nhập lại mật khẩu mới:"
        confirmTextbox.placeholder = "Điền lại mật khẩu mới"
    }
}

// MARK: - Handle Action
extension DetailSettingViewController {
    
}

extension DetailSettingViewController: DetailSettingControllerProtocol {
    func set(model: DetailSettingContract.Model) {
        self.model = model
    }
}
