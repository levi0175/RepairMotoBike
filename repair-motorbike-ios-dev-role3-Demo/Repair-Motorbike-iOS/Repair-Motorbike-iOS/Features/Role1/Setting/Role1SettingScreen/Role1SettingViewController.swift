//  
//  Role1SettingViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import UIKit

final class Role1SettingViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var logoutButton: UIButton!
    @IBOutlet private weak var serviceButton: UILabel!
    @IBOutlet private weak var voteButton: UILabel!
   // @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var nameLabelTit: UILabel!
    @IBOutlet private weak var addressLabelTit: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var phoneLabelTit: UILabel!
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var nameView: UIView!
    @IBOutlet private weak var addressView: UIView!
    @IBOutlet private weak var phoneView: UIView!
    @IBOutlet private weak var serviceView: UIView!
    @IBOutlet private weak var voteView: UIView!
    // MARK: - Variables
    private var model: Role1SettingContract.Model?
    private var dataStore: Role1SettingViewEntity?
    private var dataString: [String] = []
    private let dateFormatterPrint = DateFormatter()
    private let date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupUI()
    }
    
    @IBAction func showService(_ sender: Any) {
        let notificationVC = UIStoryboard(name: NameConstant.Storyboard.Notification, bundle: nil).instantiateVC(NotificationViewController.self)
        notificationVC.set(model: NotificationModel())
       navigationController?.pushViewController(notificationVC, animated: true)
    }
    @IBAction func showComment(_ sender: Any) {
        let notificationVC = UIStoryboard(name: NameConstant.Storyboard.Notification, bundle: nil).instantiateVC(NotificationViewController.self)
        notificationVC.set(model: NotificationModel())
       navigationController?.pushViewController(notificationVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
}

// MARK: - Setup UI
extension Role1SettingViewController {
    private func setupUI() {
        getData()
        setupButton()
        setupNavi()
       // setupTableView()
    }
    
    private func setupNavi() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.View.Red ?? UIColor.red]
        navigationController?.navigationBar.barTintColor = AppColor.View.White
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = AppColor.View.Red
        navigationController?.navigationBar.barStyle = .black
     //   navigationController?.navigationItem.titleView?.tintColor = AppColor.View.White
        navigationController?.navigationBar.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(0.5), width: 0.4)
        navigationItem.title = "Cửa hàng của tôi"
    }
    
    private func setupButton() {
        logoutButton.setTitle(Localization.Setting.Logout, for: .normal)
    }
    private func setupOutlet() {
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        dateLabel.text = self.dateFormatterPrint.string(from: self.date)
        containView.layer.cornerRadius = 15
        nameLabel.text = dataStore?.data?.name
        addressLabel.text = dataStore?.data?.address
        phoneLabel.text = dataStore?.data?.phone
        nameView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(1), width: 0.5)
        phoneView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(1), width: 0.5)
        addressView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(1), width: 0.5)
        serviceView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(1), width: 0.5)
        containView.addBorder(side: .top, color: .lightGray.withAlphaComponent(1), width: 0.5)
        voteView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(1), width: 0.5)
        nameLabel.setSizeFont1(sizeFont: 25, font1: Font.FontName.RobotoRegular.rawValue)
        addressLabel.setSizeFont1(sizeFont: 25, font1: Font.FontName.RobotoRegular.rawValue)
        phoneLabel.setSizeFont1(sizeFont: 25, font1: Font.FontName.RobotoRegular.rawValue)
        nameLabelTit.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoMedium.rawValue)
        addressLabelTit.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoMedium.rawValue)
        phoneLabelTit.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoMedium.rawValue)
        serviceButton.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoMedium.rawValue)
        voteButton.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoMedium.rawValue)
    }

    private func getData() {
        let userId = UserDefaults.standard.integer(forKey: NameConstant.UserDefaults.userID)
        model?.getStore(id: userId) { result in
            switch result {
            case .success(let data):
                self.dataStore = data
              //  self.tableView.reloadData()
                self.setupOutlet()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Handle Action
extension Role1SettingViewController {
    @IBAction private func tapButtonLogout(_ sender: UIButton) {
        model?.removeToken {
            self.refreshAppGoToAuthenticate()
        }
    }
    
    @IBAction private func tapUser(_ sender: UIButton) {
        self.refreshAppGoToTabBar()
    }
}

extension Role1SettingViewController: Role1SettingControllerProtocol {
    func set(model: Role1SettingContract.Model) {
        self.model = model
    }
}

// extension Role1SettingViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCellNib(type: Role1SettingTableViewCell.self, for: indexPath) else {
//                return UITableViewCell()
//            }
//            if indexPath.row == 1 {
//                  cell.setupData(AppImage.ArrayIcon.IconSetting[indexPath.row], name: SettingViewEntity.SettingRole1.nameSettingRole1[indexPath.row])
//                if let dataUser = dataStore {
//                    cell.showPhone(data: dataUser)
//                }
//                  return cell
//              }
//        cell.setupData(AppImage.ArrayIcon.IconSetting[indexPath.row], name: SettingViewEntity.SettingRole1.nameSettingRole1[indexPath.row])
//              cell.hidePhone()
//                  return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        51
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
// }
