//  
//  HomeGarageViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 21/05/2022.
//

import UIKit
import Alamofire

final class HomeGarageViewController: BaseViewController, CAAnimationDelegate {
    // MARK: - IBOutlet
    @IBOutlet private weak var sliderTableView: UITableView!
    @IBOutlet private weak var loadViewHomee: UIActivityIndicatorView!
    @IBOutlet private var containMainView: UIView!
    // MARK: - Variables
    private var data: HomeGarageViewEntity = HomeGarageViewEntity()
    private var model: HomeGarageContract.Model?
    var province = "ha noi"
    lazy var myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        sliderTableView.refreshControl = myRefreshControl
        sliderTableView.estimatedRowHeight = 281.5
        sliderTableView.rowHeight = UITableView.automaticDimension
        setupUI()
        getData(data: province)
    }
    @objc
    func refresh(sender: UIRefreshControl) {
        getData(data: province)
        sender.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
    
}

// MARK: - Setup UI
extension HomeGarageViewController {
    private func setupUI() {
        setTabView()
        loadViewHome()
    }
    func setTabView() {
        sliderTableView.delegate = self
        sliderTableView.dataSource = self
        sliderTableView.registerCellNib(type: HomeGarageTableViewCell.self)
        sliderTableView.registerCellNib(type: ChooseFeatureTableViewCell.self)
        sliderTableView.registerCellNib(type: AllGarageCLVCell.self)
    }
    func loadViewHome() {
        loadViewHomee.startAnimating()
        loadViewHomee.hidesWhenStopped = true
    }
    func loadEnd() {
        self.loadViewHomee.stopAnimating()
        self.containMainView.layer.opacity = 1
    }
}

// MARK: - Handle Action
extension HomeGarageViewController {
    func getData(data: String) {
        model?.getListShop(address: data) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                print(data)
                DispatchQueue.main.async {
                    self?.sliderTableView.reloadData()
                    self?.loadEnd()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
}
extension HomeGarageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCellNib(type: HomeGarageTableViewCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            return cell
        } else  if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCellNib(type: ChooseFeatureTableViewCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        }
        guard let cell = tableView.dequeueReusableCellNib(type: AllGarageCLVCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.config(dataGarage: data)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension HomeGarageViewController: UITableViewDelegate {
    //     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //         let height = UIScreen.main.bounds.width
    //        if section == 2 {
    //            return height / 200
    //        }
    //         return 0
    //   }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.width / 2
        } else  if indexPath.section == 1 {
            return UIScreen.main.bounds.width / 2.8
        }
        return UITableView.automaticDimension
    }
 
}
extension HomeGarageViewController: FirstChildVCDelegate {
    func changeScreenProvinece(data: String) {
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(ProvinceeViewController.self)
        detailView.set(model: ProvinceeModel())
        detailView.delegate = self
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func didAction(data: String) {
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(SearchViewController.self)
        detailView.set(model: SearchModel())
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
extension HomeGarageViewController: changeProvinceProtocol {
    func getDataString(data: String) {
        province = data
        getData(data: data)
        guard let cell = sliderTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? ChooseFeatureTableViewCell else {
            return
        }
        cell.getProvince(data: data)
        
    }
    
}
extension HomeGarageViewController: HomeGarageControllerProtocol {
    func set(model: HomeGarageContract.Model) {
        self.model = model
    }
}
extension HomeGarageViewController: passDataDetailVC {
    func passData(data: HomeGarageViewEntity.ListGarage1, dataComment: [HomeGarageViewEntity.CommentsHung], dataService: [HomeGarageViewEntity.ServiceListGaraHung]) {
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Detail, bundle: nil).instantiateVC(DetailShopViewController.self)
        detailView.set(model: DetailShopModel())
        detailView.listData = data
        detailView.listComment = dataComment
        detailView.listService = dataService
        navigationController?.pushViewController(detailView, animated: true)
    }
}
extension UIView {
    var parentCell1: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
