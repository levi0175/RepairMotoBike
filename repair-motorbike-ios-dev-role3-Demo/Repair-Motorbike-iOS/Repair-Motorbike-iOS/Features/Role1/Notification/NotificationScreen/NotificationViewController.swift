//  
//  NotificationViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import UIKit
import UserNotifications

final class NotificationViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Variables
    private var model: NotificationContract.Model?
    private var data: NotificationViewEntity?
    private let userId = UserDefaults.standard.integer(forKey: NameConstant.UserDefaults.userID)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListService()
    }
}

// MARK: - Setup UI
extension NotificationViewController {
    private func setupUI() {
        setupTableView()
        configureUI()
        self.tappedHideKeyboard()
        navigationController?.navigationBar.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(0.4), width: 0.3)
    }
    func getListService() {
        model?.getListService(userId: userId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(type: NotificationTableViewCell.self)
    }
    func configureUI() {
        // view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.View.Red ?? UIColor.red]
        navigationController?.navigationBar.barTintColor = AppColor.View.White
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = AppColor.View.Red
        navigationController?.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Thêm",
            style: .plain,
            target: self,
            action: #selector(addButton)
        )
        navigationItem.title = "Các dịch vụ"
    }
    @objc
    private func addButton() {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Notification, bundle: nil).instantiateVC(AddServiceViewController.self)
        // vc.data = data.listData[indexPath.row].serviceDTOList
        vc.modalPresentationStyle = .overFullScreen
        vc.check = false
        vc.set(model: AddServiceModel())
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        vc.view.layer.add(transition, forKey: nil)
        //  self.navigationController?.view.layer.add(transition, forKey: nil)
        vc.handleReload = { [weak self]  in
            guard self != nil else {
                return
            }
            self?.getListService()
        }
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - Handle Action
extension NotificationViewController {
}

extension NotificationViewController: NotificationControllerProtocol {
    func set(model: NotificationContract.Model) {
        self.model = model
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.services.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: NotificationTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        if let data = data {
            cell.setupData(data: data.services[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Approve = UITableViewRowAction(style: .normal, title: "Sửa") { _, _ in
            self.ApproveFunc(indexPath: indexPath)
        }
        Approve.backgroundColor = .green
        let Reject = UITableViewRowAction(style: .normal, title: "Xoá") { _, _ in
            
            self.rejectFunc(indexPath: indexPath)
        }
        Reject.backgroundColor = .red
        return [Reject, Approve]
    }
    func ApproveFunc(indexPath: IndexPath) {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Notification, bundle: nil).instantiateVC(AddServiceViewController.self)
        // vc.data = data.listData[indexPath.row].serviceDTOList
        vc.modalPresentationStyle = .overFullScreen
        if let data = data {
            vc.dataEdit = data.services[indexPath.row]
        }
        vc.check = true
        vc.set(model: AddServiceModel())
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        vc.view.layer.add(transition, forKey: nil)
        vc.handleReload = { [weak self]  in
            guard self != nil else {
                return
            }
            self?.getListService()
        }
        self.present(vc, animated: true, completion: nil)
    }
    func rejectFunc(indexPath: IndexPath) {
        self.model?.deleteService(idStore: userId, idService: data?.services[indexPath.row].serviceId ?? 1) { [weak self] result in
            switch result {
            case .success(let data):
                // self?.data = data
                print(data)
                DispatchQueue.main.async {
                }
                self?.data?.services.remove(at: indexPath.row)
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .right)
                self?.tableView.endUpdates()
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(rotationAngle: 360)
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.transform = CGAffineTransform(rotationAngle: 0.0)
        })
    }
    
}
