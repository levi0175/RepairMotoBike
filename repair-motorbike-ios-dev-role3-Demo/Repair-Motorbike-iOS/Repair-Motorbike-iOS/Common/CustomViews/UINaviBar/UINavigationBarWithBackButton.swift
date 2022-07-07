//
//  UINavigationBarWithBackButton.swift
//  Order-Food-iOS
//
//  Created by Aplle on 11/05/2022.
//

import UIKit

class UINavigationBarWithBackButton: UIView {
    
    @IBOutlet private weak var navigationBarView: UINavigationBar!
    @IBOutlet private weak var navigationBarItems: UINavigationItem!
    @IBOutlet private weak var backBtn: UIBarButtonItem!
    @IBOutlet private weak var saveBtn: UIBarButtonItem!
    
    private var actionBack: (() -> Void)?
    private var actionSave: (() -> Void)?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubViewAutoresizing(loadViewFromNib())
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationBarItems.hidesBackButton = true
        navigationBarItems.titleView?.tintColor = AppColor.View.Red
    }
    func setBackGround() {
        navigationBarView.barTintColor = UIColor.black
        saveBtn.tintColor = UIColor.black
    }
    func setBackGroundBlack() {
        navigationBarView.tintColor = AppColor.View.Black
    }
    func configData(title: String) {
        navigationBarItems.title = title
    }
    
    func tappedBack(handleBack: @escaping () -> Void) {
        actionBack = handleBack
    }
    
    func tappedSave(handleSave: @escaping () -> Void) {
        actionSave = handleSave
    }
    
    func hiddenBack() {
        backBtn.tintColor = AppColor.View.White
        backBtn.isEnabled = false
    }
    
    func hiddenSave() {
        saveBtn.tintColor = AppColor.View.White
        saveBtn.isEnabled = false
    }
    func addItem() {
        saveBtn.title = "Thêm"
        saveBtn.tintColor = AppColor.View.White
        saveBtn.isEnabled = true
    }
    func setupAuth() {
        navigationBarItems.title = ""
        saveBtn.tintColor = AppColor.View.Red
        navigationBarView.barTintColor = AppColor.View.Red
    }
    
    @IBAction func tabBackButton(_ sender: Any) {
        if let action = actionBack {
            action()
        }
    }
    
    @IBAction func tabSaveButton(_ sender: Any) {
        if let action = actionSave {
            action()
        }
    }
}
