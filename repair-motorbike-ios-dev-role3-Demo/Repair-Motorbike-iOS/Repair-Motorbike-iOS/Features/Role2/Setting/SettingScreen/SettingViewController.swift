//
//  SettingViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit

final class SettingViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var logoutButton: UIButton!
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    // MARK: - Variables
    private var model: SettingContract.Model?
    var pushData: AuthenticateAPIResponse?
    var dataUser: SettingViewEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
}

// MARK: - Setup UI
extension SettingViewController {
    private func setupUI() {
        setupTableView()
        setupNavi()
    }
    
    private func setupNavi() {
        naviBar.configData(title: "Tài khoản")
        naviBar.hiddenBack()
        naviBar.hiddenSave()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(type: UserSettingCell.self)
    }
    
    private func getData() {
        let userId = UserDefaults.standard.integer(forKey: NameConstant.UserDefaults.userID)
        model?.getUser(id: userId) { result in
            switch result {
            case .success(let data):
                self.dataUser = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
// MARK: - Handle Action
extension SettingViewController {
    @IBAction private func tapButtonLogout(_ sender: UIButton) {
        model?.removeToken {
            self.refreshAppGoToAuthenticate()
        }
    }
    
    @IBAction private func tapRegisterStore(_ sender: Any) {
        self.refreshAppGoToTabBarRole1()
    }
}

extension SettingViewController: SettingControllerProtocol {
    func set(model: SettingContract.Model) {
        self.model = model
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: UserSettingCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        
      if indexPath.row == 1 {
            cell.setupData(AppImage.ArrayIcon.IconSetting[indexPath.row], name: SettingViewEntity.Setting.nameSetting[indexPath.row])
          if let dataUser = dataUser {
              cell.showPhone(data: dataUser)
          }
            return cell
        }
            cell.setupData(AppImage.ArrayIcon.IconSetting[indexPath.row], name: SettingViewEntity.Setting.nameSetting[indexPath.row])
        cell.hidePhone()
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        51
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let detail = UIStoryboard(name: NameConstant.Storyboard.Setting, bundle: nil).instantiateVC(UpdateUserViewController.self)
            detail.set(model: UpdateUserModel())
            detail.dataUser = dataUser
            navigationController?.pushViewController(detail, animated: true)
        case 3:
            let detail = UIStoryboard(name: NameConstant.Storyboard.Setting, bundle: nil).instantiateVC(DetailSettingViewController.self)
            detail.set(model: DetailSettingModel())
            detail.dataUser = dataUser
            navigationController?.pushViewController(detail, animated: true)
        case 4:
            let registerStoreVC = UIStoryboard(name: NameConstant.Storyboard.Setting, bundle: nil).instantiateVC(RegisterStoreViewController.self)
            registerStoreVC.set(model: RegisterStoreModel())
            registerStoreVC.dataUser = dataUser
            navigationController?.pushViewController(registerStoreVC, animated: true)
        default:
            break
        }
    }
}
