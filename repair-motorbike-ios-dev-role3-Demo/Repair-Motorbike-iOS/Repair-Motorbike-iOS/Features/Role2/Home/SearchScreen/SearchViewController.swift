//
//  SearchViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 02/05/2022.
//

import UIKit

class SearchViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var listShopTableView: UITableView!
    // MARK: - Variables
    private var data: SearchViewEntity? = SearchViewEntity()
    private var searchData: SearchViewEntity? = SearchViewEntity()
    private var model: SearchContract.Model?
    private var statusSearchBar = false
    private var countLoad: Int = 10
    private var limit: Int = 5
    private var index: Int = 0
    public var check: Bool = false
    private let searchBarItem = UISearchBar()
    public var handleChange: ((SearchViewEntity.ListShopSearch) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        model?.getListSearch { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                print(data)
                DispatchQueue.main.async {
                    self?.listShopTableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
        listShopTableView.tableFooterView = UIView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
    }
}
// MARK: - Setup UI
extension SearchViewController {
    func setupUI() {
        self.tappedHideKeyboard()
        setupTableView()
        configureUI()
        setupSearchBar()
    }
    func setupTableView() {
        listShopTableView.registerCellNib(type: SearchGarageTBVCell.self)
        listShopTableView.dataSource = self
        listShopTableView.delegate = self
    }
    func setupSearchBar() {
        self.navigationItem.title = NameConstant.Search.title
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
    
}
// MARK: - Handle Action
extension SearchViewController {
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
        navigationItem.titleView = show ?searchBarItem : nil
    }
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if statusSearchBar == false, data?.listAllShop.isEmpty == false {
            if let data = data {
                if data.listAllShop.count < countLoad {
                    return data.listAllShop.count
                }
                return countLoad
            }
        }
        return searchData?.listAllShop.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if statusSearchBar == false {
            guard let cell = tableView.dequeueReusableCellNib(type: SearchGarageTBVCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            if let data = data {
                cell.config(data: data.listAllShop[indexPath.row].search)
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCellNib(type: SearchGarageTBVCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        if let searchData = searchData {
            cell.config(data: searchData.listAllShop[indexPath.row].search)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if check == true {
            if statusSearchBar == false {
                if let data = data {
                    handleChange?(data.listAllShop[indexPath.row])
                }
                dismiss(animated: true)
            } else {
                
                if let searchData = searchData {
                    handleChange?(searchData.listAllShop[indexPath.row])
                }
                dismiss(animated: true)
            }
        } else {
            if statusSearchBar == false {
                let detailView = UIStoryboard(name: NameConstant.Storyboard.Detail, bundle: nil).instantiateVC(DetailShopViewController.self)
                detailView.set(model: DetailShopModel())
                if let data = data {
                    detailView.listData = data.listAllShop[indexPath.row].search
                    detailView.listComment = data.listAllShop[indexPath.row].search.comments
                    detailView.listService = data.listAllShop[indexPath.row].search.serviceList
                }
                navigationController?.pushViewController(detailView, animated: true)
            } else {
                let detailView = UIStoryboard(name: NameConstant.Storyboard.Detail, bundle: nil).instantiateVC(DetailShopViewController.self)
                detailView.set(model: DetailShopModel())
                if let searchData = searchData {
                    detailView.listData = searchData.listAllShop[indexPath.row].search
                }
                navigationController?.pushViewController(detailView, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.self.countLoad - 1, self.countLoad < self.data?.listAllShop.count ?? 0 {
            tableView.addLoading(indexPath) {
                var index = self.countLoad
                self.limit = index + 5
                while index < self.limit {
                    index += 1
                    self.countLoad = index
                    if self.countLoad == self.data?.listAllShop.count ?? 0 {
                        break
                    }
                }
                self.perform(#selector(self.loadTable), with: nil, afterDelay: 1.0)
                let rotationTransForm = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
                cell.layer.transform = rotationTransForm
                UIView.animate(withDuration: 1.0) {
                    cell.layer.transform = CATransform3DIdentity
                }
                tableView.stopLoading()
            }
        }
    }
    @objc
    func loadTable() {
        self.listShopTableView.reloadData()
        
    }
}
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            statusSearchBar = false
        } else {
            statusSearchBar = true
        }
        if let data = data {
            searchData?.listAllShop = searchText.isEmpty ? data.listAllShop : data.listAllShop.filter({(dataString: SearchViewEntity.ListShopSearch) -> Bool in
                dataString.search.name?.range(of: searchText, options: .caseInsensitive) != nil
            })
            listShopTableView.reloadData()
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

extension SearchViewController: SearchControllerProtocol {
    func set(model: SearchModelProtocol) {
        self.model = model
    }
    
}
