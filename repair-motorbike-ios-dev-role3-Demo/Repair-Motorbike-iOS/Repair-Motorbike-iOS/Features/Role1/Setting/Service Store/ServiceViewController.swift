//  
//  ServiceViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 19/05/2022.
//

import UIKit

final class ServiceViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    // MARK: - Variables
    private var model: ServiceContract.Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
}

// MARK: - Setup UI
extension ServiceViewController {
    private func setupUI() {
        setupNaviBar()
    }
    
    private func setupNaviBar() {
        naviBar.configData(title: "Chỉnh sửa dịch vụ")
        naviBar.tappedBack {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Handle Action
extension ServiceViewController {
}

extension ServiceViewController: ServiceControllerProtocol {
    func set(model: ServiceContract.Model) {
        self.model = model
    }
}
