//
//  RegisterStoreViewControllerViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 18/05/2022.
//

import UIKit

final class RegisterStoreViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    @IBOutlet private weak var nameTextbox: UITextbox!
    @IBOutlet private weak var addressTextbox: UITextbox!
    @IBOutlet private weak var phoneTextbox: UITextbox!
    @IBOutlet private weak var nameServiceTextbox: UITextbox!
    @IBOutlet private weak var priceTextbox: UITextbox!
    @IBOutlet private weak var vehicleTextbox: UITextbox!
    // MARK: - Variables
    private var model: RegisterStoreContract.Model?
    var dataUser: SettingViewEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tappedHideKeyboard()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
}

// MARK: - Setup UI
extension RegisterStoreViewController {
    private func setupUI() {
        setupNaviBar()
        setupTextbox()
    }
    
    private func setupNaviBar() {
        naviBar.configData(title: "Đăng kí cửa hàng")
        naviBar.tappedBack {
            self.navigationController?.popViewController(animated: true)
        }
        naviBar.tappedSave {
            let address = self.addressTextbox.contentTextField.text
            
            let name = self.nameTextbox.contentTextField.text
            
            let phone = self.phoneTextbox.contentTextField.text
            
            let nameService = self.nameServiceTextbox.contentTextField.text
            
            let price = Int(self.priceTextbox.contentTextField.text ?? "")
            
            let vehicle = self.vehicleTextbox.contentTextField.text
            
            let data: RegisterStoreRequest = RegisterStoreRequest(name: name, address: address, phone: phone, services: [Services(name: nameService, price: price, typeVehicle: vehicle)])
            
            self.model?.registerStore(id: self.dataUser?.data!.userId ?? 0, data: data) { [weak self] result in
                switch result {
                case .success:
                    self?.showAlert(message: "Đăng kí thành công!")
                case .failure(let error):
                    self?.showAlert(message: error.message)
                    print(error)
                }
            }
        }
    }
    
    private func setupTextbox() {
        nameTextbox.title = "Tên cửa hàng:"
        nameTextbox.placeholder = "Điền tên cửa hàng"
        addressTextbox.title = "Địa chỉ cửa hàng:"
        addressTextbox.placeholder = "Điền địa chỉ cửa hàng"
        phoneTextbox.title = "Số điện thoại:"
        phoneTextbox.placeholder = "Điền số điện thoại"
        nameServiceTextbox.title = "Tên dịch vụ:"
        nameServiceTextbox.placeholder = "Điền tên dịch vụ"
        priceTextbox.title = "Giá dịch vụ:"
        priceTextbox.placeholder = "Điền giá dịch vụ"
        vehicleTextbox.title = "Loại xe:"
        vehicleTextbox.placeholder = "Điền loại xe"
    }
}

// MARK: - Handle Action
extension RegisterStoreViewController {
}

extension RegisterStoreViewController: RegisterStoreControllerProtocol {
    func set(model: RegisterStoreContract.Model) {
        self.model = model
    }
}
