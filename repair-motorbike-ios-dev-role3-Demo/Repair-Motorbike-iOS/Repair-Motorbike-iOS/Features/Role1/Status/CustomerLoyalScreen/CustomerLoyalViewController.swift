//  
//  CustomerLoyalViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import UIKit

final class CustomerLoyalViewController: BaseViewController {
    // MARK: - IBOutlet
    
    @IBOutlet private weak var listBookingTableView: UITableView!
    
    // MARK: - Variables
    private var model: CustomerLoyalContract.Model?
    private var data: CustomerLoyalViewEntity?
    private var dataSearch: [CustomerLoyalViewEntity.ListUserLoyal] = []
    private var dataSearch1: [CustomerLoyalViewEntity.ListUserLoyal] = []
    private var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model?.getListUserLoyal { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                self?.dataSearch1 = data.listUser
                self?.dataSearch = self?.dataSearch1 ?? []
                DispatchQueue.main.async {
                    self?.listBookingTableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
}

// MARK: - Setup UI
extension CustomerLoyalViewController {
    private func setupUI() {
        configureUI()
        setupTableView()
        navigationController?.navigationBar.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(0.4), width: 0.3)
    }
    private func setupTableView() {
        listBookingTableView.registerCellNib(type: CustomerLoyalCell.self)
        listBookingTableView.dataSource = self
        listBookingTableView.delegate = self
    }
    private func configureUI() {
        searchBar.delegate = self
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.View.Red ?? UIColor.red]
        navigationController?.navigationBar.barTintColor = AppColor.View.White
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = AppColor.View.Red
        navigationController?.navigationBar.barStyle = .black
      //  navigationController?.navigationItem.titleView?.tintColor = AppColor.View.White
        navigationItem.title = "Khách hàng thân thiết"
        showSearchBarButton(show: true)
    }
}

// MARK: - Handle Action
extension CustomerLoyalViewController {
    @objc
    private func handleShowSearchBar() {
        search(show: true)
        searchBar.becomeFirstResponder()
    }
    private func showSearchBarButton(show: Bool) {
        if show {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    private func search(show: Bool) {
        showSearchBarButton(show: !show)
        searchBar.showsCancelButton = show
        navigationItem.titleView = show ? searchBar : nil
    }
}
extension CustomerLoyalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: CustomerLoyalCell.self, for: indexPath) else {
            return UITableViewCell()
        }
//        if let data = data {
            cell.config(data: dataSearch[indexPath.row])
      //  }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(withDuration: 3, delay: 0.03 * Double(indexPath.row), usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
              cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width - 10, y: cell.contentView.frame.height)
        })
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hung")
    }
}
extension CustomerLoyalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
}
extension CustomerLoyalViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        search(show: false)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSearch = []
        if searchText == ""{
            dataSearch = dataSearch1
        } else {
            dataSearch = searchText.isEmpty ? dataSearch1 : dataSearch1.filter({(dataString: CustomerLoyalViewEntity.ListUserLoyal) -> Bool in
                dataString.phone?.range(of: searchText, options: .caseInsensitive) != nil
            })
        }
        listBookingTableView.reloadData()
    }
}
extension CustomerLoyalViewController: CustomerLoyalControllerProtocol {
    func set(model: CustomerLoyalContract.Model) {
        self.model = model
    }
}
