//  
//  UpdateUserViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 26/05/2022.
//

import UIKit

final class UpdateUserViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    @IBOutlet private weak var nameTextbox: UITextbox!
    @IBOutlet private weak var addressTextbox: UITextbox!
    @IBOutlet private weak var ageTextbox: UITextbox!
    @IBOutlet private weak var genderTextbox: UITextbox!
    // MARK: - Variables
    private var model: UpdateUserContract.Model?
    var dataUser: SettingViewEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tappedHideKeyboard()
        setupUI()
    }
}

// MARK: - Setup UI
extension UpdateUserViewController {
    private func setupUI() {
        setupTextbox()
        setupNaviBar()
    }
    
    private func setupNaviBar() {
        naviBar.tappedBack {
            self.navigationController?.popViewController(animated: true)
        }
        
        naviBar.tappedSave {
            let address = self.addressTextbox.contentTextField.text

            let name = self.nameTextbox.contentTextField.text

            let age = Int(self.ageTextbox.contentTextField.text ?? "")

            let gender = self.genderTextbox.contentTextField.text
            
            self.model?.updateUser(id: self.dataUser?.data!.userId ?? 0, name: name!, gender: gender!, phone: self.dataUser?.data?.phone ?? "", address: address!, age: age!) { [weak self] result in
                switch result {
                case .success:
                    self?.showAlert(message: "Thay đổi thành công!")
                case .failure(let error):
                    self?.showAlert(message: error.message)
                    print(error)
                }
            }
        }
        naviBar.configData(title: "Cập nhật thông tin")
    }
    
    private func setupTextbox() {
        nameTextbox.title = "Họ tên:"
        nameTextbox.text = dataUser?.data?.name ?? ""
        addressTextbox.title = "Địa chỉ:"
        addressTextbox.text = dataUser?.data?.address ?? ""
        ageTextbox.title = "Tuổi:"
        ageTextbox.text = "\(dataUser?.data?.age ?? 0)"
        genderTextbox.title = "Giới tính:"
        genderTextbox.text = dataUser?.data?.gender ?? ""
    }
}

// MARK: - Handle Action
extension UpdateUserViewController {
}

extension UpdateUserViewController: UpdateUserControllerProtocol {
    func set(model: UpdateUserContract.Model) {
        self.model = model
    }
}
