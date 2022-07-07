//  
//  RegisterViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 26/04/2022.
//

import UIKit

final class RegisterViewController: BaseViewController {
    // MARK: - IBOutlet

    @IBOutlet private weak var nameTextbox: UITextbox!
    @IBOutlet private weak var phoneTextbox: UITextbox!
    @IBOutlet private weak var addressTextbox: UITextbox!
    @IBOutlet private weak var passTextbox: UITextbox!
    @IBOutlet private weak var ageTextbox: UITextbox!
    @IBOutlet private weak var genderTextbox: UITextbox!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var registerButton: UIButton!
    
    // MARK: - Variables
    private var model: RegisterContract.Model?
    private var data: RegisterViewEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tappedHideKeyboard()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Setup UI
extension RegisterViewController {
    private func setupUI() {
        setupTextbox()
    }
    
    private func setupTextbox() {
        phoneTextbox.title = "Số điện thoại:"
        phoneTextbox.placeholder = "Điền số điện thoại"
        passTextbox.title = "Mật khẩu:"
        passTextbox.placeholder = "Điền mật khẩu"
        nameTextbox.title = "Họ tên:"
        nameTextbox.placeholder = "Điền họ tên"
        addressTextbox.title = "Địa chỉ:"
        addressTextbox.placeholder = "Điền địa chỉ"
        ageTextbox.title = "Tuổi:"
        ageTextbox.placeholder = "Điền tuổi"
        genderTextbox.title = "Giới tính:"
        genderTextbox.placeholder = "Điền giới tính"
    }

    private func showError(_ error: String) {
        Logger.debug("Login error: \(error)")
    }
}

// MARK: - Handle Action
extension RegisterViewController {
    @IBAction private func tapButtonRegister(_ sender: UIButton) {
        let phone = phoneTextbox.contentTextField.text
        if phone?.isEmpty == true {
            self.showAlert(title: "Thông báo", message: "Mời nhập số điện thoại")
        } else if phone?.count != 10 {
            self.showAlert(title: "Thông báo", message: "Số điện thoại không đúng định dạng")
            return
        }
        
        let password = passTextbox.contentTextField.text
        if password?.isEmpty == true {
            self.showAlert(title: "Thông báo", message: "Mời nhập mật khẩu")
        }
        
        let address = addressTextbox.contentTextField.text
        if address?.isEmpty == true {
            self.showAlert(title: "Thông báo", message: "Mời nhập địa chỉ")
        }

        let name = nameTextbox.contentTextField.text
        if name?.isEmpty == true {
            self.showAlert(title: "Thông báo", message: "Mời nhập tên")
        }
//        guard let gender = sexTextField.text, gender.isEmpty == false else {
//            showError("Please input password")
//            return
//        }

//        model?.register(name: name, phone: phone, password: password, old: old, sex: sex) { [weak self] result in
//            switch result {
//                case .success:
//                    Logger.debug("Register success!")
//                    self?.refreshAppGoToTabBarRole1()
//                case .failure(let error):
//                    Logger.debug("Login failure!")
//                    self?.showAlert(message: "\(error)")
//            }
//        }
        
//        self.refreshAppGoToAuthenticate()

        let age = Int(ageTextbox.contentTextField.text ?? "")
        if age?.words.isEmpty == true {
            self.showAlert(title: "Thông báo", message: "Mời nhập tên")
        }

        let gender = genderTextbox.contentTextField.text
        if gender?.isEmpty == true {
            self.showAlert(title: "Thông báo", message: "Mời nhập giới tính")
        }
    
        model?.register(name: name!, phone: phone!, password: password!, address: address!, age: age ?? 0, gender: gender!) { [weak self] result in

            switch result {
            case .success:
                Logger.debug("Register success!")
                self?.showAlert(message: "Register success!")
                self?.refreshAppGoToAuthenticate()
            case .failure:
                Logger.debug("Register failure!")
                self?.showAlert(message: "Register failure!")
            }
        }
    }
    
    @IBAction private func tapButtonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func taplogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func keyboardWillShow(sender: NSNotification) {
        self.contentView.frame.origin.y -= 100
    }
    @objc
    func keyboardWillHide(sender: NSNotification) {
        self.contentView.frame.origin.y += 100
    }
}

extension RegisterViewController: RegisterControllerProtocol {
    func set(model: RegisterContract.Model) {
        self.model = model
    }
}
