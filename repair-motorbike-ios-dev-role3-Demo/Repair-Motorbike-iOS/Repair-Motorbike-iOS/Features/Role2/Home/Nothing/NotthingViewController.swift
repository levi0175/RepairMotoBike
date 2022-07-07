//
//  NotthingViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 17/05/2022.
//

import UIKit

class NotthingViewController: UIViewController {
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
    }
    private func setupNavi() {
        naviBar.configData(title: "Dịch vụ")
        naviBar.tappedBack {
            self.navigationController?.popViewController(animated: true)
        }
        naviBar.hiddenSave()
    }
}
