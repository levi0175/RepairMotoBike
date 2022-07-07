//
//  BaseNavigationController.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customBack()
    }
    
    func customBack() {
        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: AppImage.Icon.Back), style: .plain, target: self, action: #selector(backButton))
        backButton.tintColor = AppColor.View.White
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    func backButton() {
        navigationController?.popViewController(animated: true)
    }
}
