//  
//  AddServiceViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 07/06/2022.
//

import UIKit

final class AddServiceViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var nameView: UITextbox!
    @IBOutlet private weak var priceView: UITextbox!
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var typeView: UITextbox!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var addButton: UIButton!
    // MARK: - Variables
    private var model: AddServiceContract.Model?
    private var data: AddServiceViewEntity?
    public var dataEdit: DetailShopViewEntity.ListShop?
    public var handleReload: (() -> Void)?
    public var check = false
    private let userId = UserDefaults.standard.integer(forKey: NameConstant.UserDefaults.userID)
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.hideTitle()
        priceView.hideTitle()
        typeView.hideTitle()
        setupUI()
        self.tappedHideKeyboard()
    }
  
}

// MARK: - Setup UI
extension AddServiceViewController {
    private func setupUI() {
        setupTextbox()
    }
    private func setupTextbox() {
        if check == false {
            addButton.setTitle("Thêm", for: .normal)
            nameView.title = "Tên dịch vụ:"
            nameView.placeholder = "Điền tên dịch vụ"
            priceView.title = "Giá:"
            priceView.placeholder = "Điền giá"
            typeView.title = "Kiểu xe"
            // xe ga, xe so, xe con
            typeView.placeholder = "Điền kiểu xe"
            
        } else {
            addButton.setTitle("Sửa", for: .normal)
            nameView.contentTextField.text = dataEdit?.name
            priceView.contentTextField.text = "\(dataEdit?.price ?? 0.0)"
            typeView.contentTextField.text = dataEdit?.typeVehicle
        }
        containView.dropShadowWithCornerRaduis(corlor: UIColor.white)
        containView.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
        nameView.borderView()
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        nameView.layer.cornerRadius = 15
        addButton.layer.cornerRadius = 6
        
    }
}

// MARK: - Handle Action
extension AddServiceViewController {
    func dismissViewController() {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        handleReload?()
        self.tappedHideKeyboard()
        dismiss(animated: true)
    }
    @IBAction func back(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        dismiss(animated: true)
    }
    @IBAction func Add(_ sender: Any) {
   
            if check == false {
                model?.postService(userId: userId, name: nameView.contentTextField.text ?? "", price: Double(priceView.contentTextField.text ?? "0") ?? 0.0, typeVehicle: typeView.contentTextField.text ?? "" ) { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.data = data
                        DispatchQueue.main.async {
                            self?.showAlert(message: "Thêm thành công")
                            self?.dismissViewController()
                        }
                    case .failure(let error):
                        self?.showAlert(message: "\(error)")
                    }
                }
            } else {
                if let dataEdit = dataEdit {
                model?.updateService(userId: userId, serviceId: dataEdit.serviceId,
                                     name: nameView.contentTextField.text ?? "",
                                     price: Double(priceView.contentTextField.text ?? "0") ?? 0.0,
                                     typeVehicle: typeView.contentTextField.text ?? "") { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.data = data
                        DispatchQueue.main.async {
                            self?.showAlert(message: "Sửa thành công")
                            self?.dismissViewController()
                        }
                    case .failure(let error):
                        self?.showAlert(message: "\(error)")
                    }
                }
            }
        }
    }
}

extension AddServiceViewController: AddServiceControllerProtocol {
    func set(model: AddServiceContract.Model) {
        self.model = model
    }
}
