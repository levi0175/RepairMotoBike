//
//  DetailShopViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 29/04/2022.
//

import UIKit
import GoogleMaps
final class DetailShopViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var imageGarage: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bigMap: UIView!
    @IBOutlet private weak var bookingView: UIView!
    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var nameShopLbl: UILabel!
    @IBOutlet private weak var numberVoteShopLbl: UILabel!
    @IBOutlet private weak var numberMessShopLbl: UILabel!
    
    @IBOutlet private weak var extentionGooglemaps: UIButton!
    @IBOutlet private weak var bookButton: UIButton!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var tabViewDetail: UITabViewCommon!
    @IBOutlet private weak var contentVIew: UIView!
    @IBOutlet private weak var addressShopLbl: UILabel!
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    @IBOutlet private weak var heightTBV: NSLayoutConstraint!
    
    @IBOutlet private weak var contrainHeightClV: NSLayoutConstraint!
    
    @IBOutlet private weak var loadViewHomee: UIActivityIndicatorView!
    // MARK: - Variables
    private var model: DetailShopContract.Model?
    public var listData: HomeGarageViewEntity.ListGarage1?
    public var listComment: [HomeGarageViewEntity.CommentsHung] = []
    public var listService: [HomeGarageViewEntity.ServiceListGaraHung] = []
    private var dataStoreService: DetailShopViewEntity?
    private var dataComment: DetailShopViewEntity?
    private let locationManagerDetail = CLLocationManager()
    private var nextBtn = 0
    public var nameShop: String?
    public var addressShop: String?
    private var height1 = 0
    private var countLoad: Int = 10
    private var limit: Int = 5
    private var index: Int = 0
    private var contentSizeObservation: NSKeyValueObservation?
    private var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        
        contentSizeObservation = tableView.observe(\UITableView.contentSize, options: [.new]) { (_, change) in
            if let newSize = change.newValue {
                self.heightTBV.constant = newSize.height * 1.05
            }
        }
        pullRefesh()
        getListService()
        getListComment()
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        //        self.tableView.removeObserver(self, forKeyPath: "ContentView1")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = true
        numberMessShopLbl.text = String(listComment.count)
        numberVoteShopLbl.text = String(listService.count)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        self.tableView.layoutIfNeeded()
        //        self.heightTBV.constant = self.tableView.contentSize.height + 340
    }
    //    override
    //    func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
    //        if object is UITableView {
    //            if keyPath == "ContentView1" {
    //                if let newValue = change?[.newKey] {
    //                    let newSize = newValue as? CGSize
    //                    self.contrainHeightClV.constant = newSize!.height
    //                }
    //            }
    //        }
    //    }
}
// MARK: - Setup UI
extension DetailShopViewController {
    private func setupUI() {
        setupCollectionView()
        setMapView()
        setCurrentLocotion()
        setupDataOutlet()
        setupBookViewDetail()
        setupBigMapDetail()
        setupView()
        setVoteView()
        blurUIViewMap()
        setupNavi()
        //  loadViewHome()
    }
    func loadViewHome() {
        tableView.tableFooterView = UIView()
        loadViewHomee.startAnimating()
        loadViewHomee.hidesWhenStopped = true
        contentVIew.alpha = 0.5
        // UIScreen.main.brightness = CGFloat(0.5)
    }
    func loadEnd() {
        self.loadViewHomee.stopAnimating()
        loadViewHomee.hidesWhenStopped = true
        contentVIew.alpha = 1
    }
    private func setupNavi() {
        naviBar.configData(title: listData?.name ?? "Chi tiết")
        naviBar.tappedBack {
            self.navigationController?.popViewController(animated: true)
        }
        naviBar.hiddenSave()
    }
    private func blurUIViewMap() {
        let maskLayer = CAGradientLayer()
        maskLayer.frame = mapView.bounds
        maskLayer.shadowPath = CGPath(roundedRect: mapView.bounds.insetBy(dx: 5, dy: 5), cornerWidth: 6, cornerHeight: 6, transform: nil)
        maskLayer.shadowOpacity = 1
        maskLayer.shadowOffset = CGSize.zero
        maskLayer.shadowColor = UIColor.white.cgColor
        mapView.layer.mask = maskLayer
    }
    private func setupBigMapDetail() {
        let map = UIButtonBorder()
        map.textLbl = NameConstant.DetailGarage.map
        map.imageButton = UIImage(named: AppImage.Image.CheckDetail)
        map.getButtonBorder(at: bigMap)
    }
    private func setupBookViewDetail() {
        let book = UIButtonBorder()
        book.textLbl = NameConstant.DetailGarage.booking
        book.imageButton = UIImage(named: AppImage.Image.CheckDetail)
        book.getButtonBorder(at: bookingView)
    }
    private func setupDataOutlet() {
        nameShopLbl.text = listData?.name
        addressShopLbl.text = listData?.address
        nameShopLbl.setSizeFont1(sizeFont: 17, font1: Font.FontName.RobotoMedium.rawValue)
        addressShopLbl.setSizeFont1(sizeFont: 35, font1: Font.FontName.RobotoRegular.rawValue)
        numberVoteShopLbl.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        numberMessShopLbl.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
    }
    
    private func setupCollectionView() {
        tabViewDetail.addBorder(side: .bottom, color: .lightGray, width: 0.5)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(type: InfoTBVCell.self)
        tableView.registerCellNib(type: CosmosTableViewCell.self)
        tableView.registerCellNib(type: ServiceTBVCell.self)
        tableView.registerCellNib(type: CommentTableViewCell.self)
    }
    private func setupView() {
        tabViewDetail.delegate = self
        tabViewDetail.textLeft = NameConstant.DetailGarage.infomation
        tabViewDetail.textBottom = NameConstant.DetailGarage.service
        tabViewDetail.textRight = NameConstant.DetailGarage.vote
    }
    private func setVoteView() {
        nextBtn = 2
        tabViewDetail.type = .bottom
    }
}
// MARK: - Handle Action
extension DetailShopViewController {
    func pullRefesh() {
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    @objc
    func refresh() {
        getListComment()
        getListService()
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    func getListService() {
        model?.getListStoreService(storeId: listData?.storeId ?? 1) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataStoreService = data
                print(data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
    func getListComment() {
        model?.getlistComment(storeId: listData?.storeId ?? 1) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataComment = data
                print(data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    
                    self?.loadEnd()
                    
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBooking(_ sender: Any) {
        
        let vc = UIStoryboard(name: NameConstant.Storyboard.Book, bundle: nil).instantiateVC(BookViewController.self)
        
        vc.set(model: BookModel())
        vc.checkStore = true
        vc.listData = listData
        if let data = listData {
            vc.listDataDetailShop = data.serviceList
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func extentionGoogleMap(_ sender: Any) {
        // 20.644_496, 106.419_797
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Detail, bundle: nil).instantiateVC(GoogleMapViewController.self)
        detailView.dataGoogMaps = listData
        navigationController?.pushViewController(detailView, animated: true)
    }
    func getID(id: Int) {
        nextBtn = id
        tableView.reloadData()
    }
}

// MARK: - Setup CollectionView
extension DetailShopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nextBtn == 0 {
            return 1
        } else if nextBtn == 2 {
            if let dataComment = dataComment {
                if dataComment.listCommentList.count < countLoad + 1 {
                    return dataComment.listCommentList.count + 1
                }
                return countLoad + 1
            }
        }
        return dataStoreService?.listAllStoreService.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.frame.size = tableView.contentSize
        if nextBtn == 0 {
            guard let cell = tableView.dequeueReusableCellNib(type: InfoTBVCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            return cell
        } else if nextBtn == 2 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCellNib(type: CosmosTableViewCell.self, for: indexPath) else {
                    return UITableViewCell()
                }
                cell.delegate = self
                if let listData = listData {
                    cell.getDataGara(data: listData)
                }
                if let dataComment = dataComment {
                    cell.config(data: dataComment.listCommentList)
                }
                return cell
                
            }
            guard let cell = tableView.dequeueReusableCellNib(type: CommentTableViewCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            
            if var dataComment = dataComment {
                dataComment.listCommentList.reverse()
                cell.config(data: dataComment.listCommentList[indexPath.row - 1])
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCellNib(type: ServiceTBVCell.self, for: indexPath) else {
            return UITableViewCell()
        }
    
        if let dataStoreService = dataStoreService {
            cell.configService(data: dataStoreService.listAllStoreService[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if nextBtn == 1 {
            return 50
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if nextBtn == 2 {
            if indexPath.row == self.countLoad, self.countLoad < dataComment?.listCommentList.count ?? 0 {
                tableView.addLoading(indexPath) {
                    var index = self.countLoad
                    self.limit = index + 5
                    while index < self.limit {
                        index += 1
                        self.countLoad = index
                        if self.countLoad == (self.dataComment?.listCommentList.count ?? 0) + 1 {
                            break
                        }
                    }
                }
                self.perform(#selector(self.loadTable), with: nil, afterDelay: 1.0)
                //                    let rotationTransForm = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
                //                    cell.layer.transform = rotationTransForm
                //                    UIView.animate(withDuration: 1.0) {
                //                        cell.layer.transform = CATransform3DIdentity
                //                    }
                tableView.stopLoading()
            }
        }
    }
    @objc
    func loadTable() {
        self.tableView.reloadData()
        
    }
}

extension DetailShopViewController: CLLocationManagerDelegate {
    private func setMapView() {
        locationManagerDetail.delegate = self
        // 20.647_435, 106.435_743
        let latitudeGoogleMap: Double = 20.647_435
        let longitudeGoogleMap: Double = 106.435_743
        if CLLocationManager.locationServicesEnabled() {
            locationManagerDetail.requestLocation()
            
        } else {
            locationManagerDetail.requestWhenInUseAuthorization()
        }
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: latitudeGoogleMap, longitude: longitudeGoogleMap), zoom: 0, bearing: 0, viewingAngle: 0.0)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitudeGoogleMap, longitude: longitudeGoogleMap)
        marker.title = listData?.name
        marker.snippet = listData?.address
        marker.map = mapView
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 20.647_435, longitude: 106.435_743), zoom: 0, bearing: 0, viewingAngle: 0.0)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 20.647_435, longitude: 106.435_743)
        marker.title = listData?.name
        marker.snippet = listData?.address
        marker.map = mapView
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .authorizedAlways:
                return
            case .authorizedWhenInUse:
                return
            case  .denied:
                return
            case .restricted:
                locationManagerDetail.requestWhenInUseAuthorization()
            case .notDetermined:
                locationManagerDetail.requestWhenInUseAuthorization()
            default:
                locationManagerDetail.requestWhenInUseAuthorization()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.mapView.clear()
        self.addMarker(coordinate: coordinate)
    }
    func addMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = coordinate
        marker.map = self.mapView
    }
    func setCurrentLocotion() {
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
extension DetailShopViewController: getDataCommentFromDetailProtocol {
    func getData(data: HomeGarageViewEntity.ListGarage1, numberVote: String, numberComment: Int) {
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Evaluate, bundle: nil).instantiateVC(EvaluateViewController.self)
        detailView.set(model: EvaluateModel())
        detailView.dataGara = data
        detailView.delegate = self
        navigationController?.pushViewController(detailView, animated: true)
    }
}
extension DetailShopViewController: loadCommentProtocol {
    func loadData() {
        getListComment()
    }
}
extension DetailShopViewController: passDataComment {
    func passData(data: HomeGarageViewEntity.ListGarage1, numberVote: String, numberComment: Int) {
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Evaluate, bundle: nil).instantiateVC(EvaluateViewController.self)
        detailView.set(model: EvaluateModel())
        detailView.dataGara = data
        detailView.delegate = self
        navigationController?.pushViewController(detailView, animated: true)
    }
}
extension DetailShopViewController: delegateTabViewHome {
    func handleChangeTabView(with type: UITabViewCommon.TypeTab) {
        if type == .left {
            getID(id: 1)
            tabViewDetail.type = .left
        } else if type == .bottom {
            getID(id: 2)
            tabViewDetail.type = .bottom
        } else {
            getID(id: 0)
            tabViewDetail.type = .right
        }
    }
}
extension DetailShopViewController: DetailShopControllerProtocol {
    func set(model: DetailShopContract.Model) {
        self.model = model
    }
}
