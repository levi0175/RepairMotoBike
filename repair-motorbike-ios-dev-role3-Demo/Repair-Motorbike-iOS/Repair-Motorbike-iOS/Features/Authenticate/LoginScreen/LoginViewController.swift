//
//  LoginViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit

final class LoginViewController: BaseViewController {
    // MARK: - IBOutlet
//    @IBOutlet private weak var emailTextField: UITextField!
//    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var customerButton: UIButton!
    @IBOutlet private weak var storeButton: UIButton!
    @IBOutlet private weak var getpasswordButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var emailTextbox: UITextbox!
    @IBOutlet private weak var passTextbox: UITextbox!
    // MARK: - Variables
    private var model: LoginContract.Model?
    private var check = true
    private var data: LoginViewEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tappedHideKeyboard()
        setupUI()
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Setup UI
extension LoginViewController {
    private func setupUI() {
        setupTextbox()
    }
    
    private func setupImage() {
        let logoView = UILogoView()
        logoView.startLogoViewAnimation(at: view)
    }
    
    private func showError(_ error: String) {
        Logger.debug("Login error: \(error)")
    }
    
    private func setupTextbox() {
        emailTextbox.title = "Số điện thoại"
        emailTextbox.placeholder = "Điền số điện thoại"
        passTextbox.title = "Mật khẩu"
        passTextbox.placeholder = "Điền mật khẩu"
        passTextbox.setupSecure()
    }
}

// MARK: - Handle Action
extension LoginViewController {
    @IBAction private func tapButtonLogin(_ sender: UIButton) {
        let phone = emailTextbox.contentTextField.text
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

        if check == false {
            model?.login(phone: phone!, password: password!) { [weak self] result in
                switch result {
                case .success:
                    Logger.debug("Login success!")
                    self?.refreshAppGoToTabBarRole1()
                case .failure(let error):
                    Logger.debug("Login failure!")
                    self?.showAlert(message: "\(error)")
                }
            }
        } else {
            model?.login(phone: phone!, password: password!) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.data = data
                    UserDefaults.standard.set(data.data.data?.id, forKey: NameConstant.UserDefaults.userID)
                    self?.refreshAppGoToTabBar()
                case .failure(let error):
                    Logger.debug("Login failure!")
                    print(error)
                    self?.showAlert(message: "Số điện thoại hoặc mật khẩu không đúng")
            }
        }
    }
}

@IBAction private func customerPress(_ sender: Any) {
    if check == false {
        check = true
        customerButton.setImage(UIImage(named: AppImage.Icon.Click), for: .normal)
        storeButton.setImage(UIImage(named: AppImage.Icon.unClick), for: .normal)
    } else {
        check = true
    }
}

@IBAction private func storePress(_ sender: Any) {
    if check == true {
        check = false
        customerButton.setImage(UIImage(named: AppImage.Icon.unClick), for: .normal)
        storeButton.setImage(UIImage(named: AppImage.Icon.Click), for: .normal)
    } else {
        check = false
    }
}

@IBAction private func getPass(_ sender: Any) {
    let getPassVC = UIStoryboard(name: NameConstant.Storyboard.Authenticate, bundle: nil).instantiateVC(GetPassViewController.self)
    getPassVC.set(model: GetPassModel())
    navigationController?.pushViewController(getPassVC, animated: true)
}

@IBAction private func Register(_ sender: Any) {
    let registerVC = UIStoryboard(name: NameConstant.Storyboard.Authenticate, bundle: nil).instantiateVC(RegisterViewController.self)
    registerVC.set(model: RegisterModel())
    navigationController?.pushViewController(registerVC, animated: true)
}
}

extension LoginViewController: LoginViewProtocol {
    func set(model: LoginContract.Model) {
        self.model = model
    }
}
