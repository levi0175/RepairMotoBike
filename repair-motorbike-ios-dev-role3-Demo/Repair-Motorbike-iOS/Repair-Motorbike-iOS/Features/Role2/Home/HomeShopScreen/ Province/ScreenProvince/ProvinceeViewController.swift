//  
//  ProvinceeViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 26/05/2022.
//

import UIKit
protocol changeProvinceProtocol: AnyObject {
    func getDataString(data: String)
}
final class ProvinceeViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var listProvinceTableView: UITableView!
//    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    // MARK: - Variables
    private var data: ProvinceeViewEntity? = ProvinceeViewEntity()
    private var searchData: ProvinceeViewEntity? = ProvinceeViewEntity()
    private var model: ProvinceeContract.Model?
    weak var delegate: changeProvinceProtocol?
    private var statusSearchBar = false
    public var check: Bool = false
    private let searchBarItem = UISearchBar()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        model?.getListProvince { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                print(data)
                DispatchQueue.main.async {
                    self?.listProvinceTableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
        setupUI()
    }
}
// MARK: - Setup UI
extension ProvinceeViewController {
    func setupUI() {
        setupTableView()
        setupSearchBar()
        configureUI()
       // setupNavi()
    }
    func configureUI() {
        searchBarItem.sizeToFit()
        searchBarItem.delegate = self
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.View.Red ?? UIColor.red]
        navigationController?.navigationBar.barTintColor = AppColor.View.White
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = AppColor.View.Red
        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationItem.titleView?.tintColor = UIColor.black
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        showSearchBarButton(show: true)
    }
    func setupSearchBar() {
        self.navigationItem.title = NameConstant.Search.titlePro
    }
    func setupTableView() {
        listProvinceTableView.registerCellNib(type: ProvinceCell.self)
        listProvinceTableView.dataSource = self
        listProvinceTableView.delegate = self
    }
//    private func setupNavi() {
//        naviBar.configData(title: NameConstant.Storyboard.Setting)
//        naviBar.tappedBack {
//            self.navigationController?.popViewController(animated: true)
//        }
//        naviBar.hiddenSave()
//    }
}
// MARK: - Handle Action
extension ProvinceeViewController {
    @objc
    func handleShowSearchBar() {
        search(show: true)
        searchBarItem.becomeFirstResponder()
    }
    func showSearchBarButton(show: Bool) {
        if show {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    func search(show: Bool) {
         showSearchBarButton(show: !show)
        searchBarItem.showsCancelButton = show
        navigationItem.titleView = show ? searchBarItem : nil
    }
}
extension ProvinceeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if statusSearchBar == false, data?.listAllShop.isEmpty == false {
            if let data = data {
                  return data.listAllShop.count
            }
        }
        return searchData?.listAllShop.count ?? 0

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if statusSearchBar == false {
            guard let cell = tableView.dequeueReusableCellNib(type: ProvinceCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            if let data = data {
                cell.config(data: data.listAllShop[indexPath.row])
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCellNib(type: ProvinceCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        if let searchData = searchData {
            cell.config(data: searchData.listAllShop[indexPath.row])
        }
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if statusSearchBar == false {
                if let data = data {
                    delegate?.getDataString(data: data.listAllShop[indexPath.row].list.name ?? "Ha Noi")
                }
                navigationController?.popViewController(animated: true)
            } else {
                if let search = searchData {
                    delegate?.getDataString(data: search.listAllShop[indexPath.row].list.name ?? "Ha Noi")
                }
                navigationController?.popViewController(animated: true)
    
            }
    }
}
extension ProvinceeViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             30
        }
}
extension ProvinceeViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText == ""{
                statusSearchBar = false
            } else {
                statusSearchBar = true
            }
            if let data = data {
                searchData?.listAllShop = searchText.isEmpty ? data.listAllShop : data.listAllShop.filter({(dataString: ProvinceeViewEntity.ListProvince) -> Bool in
                    dataString.list.name?.range(of: searchText, options: .caseInsensitive) != nil
                   })
                    listProvinceTableView.reloadData()
            }
        }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
       search(show: false)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
}
extension ProvinceeViewController: ProvinceeControllerProtocol {
    func set(model: ProvinceeContract.Model) {
        self.model = model
    }
}
