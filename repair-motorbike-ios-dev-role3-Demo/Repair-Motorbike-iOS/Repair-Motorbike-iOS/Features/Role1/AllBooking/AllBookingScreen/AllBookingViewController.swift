//  
//  AllBookingViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import UIKit
final class AllBookingViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var viewBlurBottom: UIView!
    @IBOutlet private weak var btnStartDate: UIButton!
    @IBOutlet private weak var btnEndDateDate: UIButton!
    @IBOutlet private weak var listBookingTableView: UITableView!
    @IBOutlet private weak var heightTBV: NSLayoutConstraint!
    // MARK: - Variables
    private var model: AllBookingContract.Model?
    private var dateFrom = Date()
    private var dateTo = Date()
    private let dateFormatter = DateFormatter()
    private let dateFormatterPrint = DateFormatter()
    private let dateFormatterPrintDay = DateFormatter()
    private var searchBar = UISearchBar()
    private var contentSizeObservation: NSKeyValueObservation?
    private var data: AllBookingViewEntity?
    private var dataDelete: AllBookingViewEntity?
    private var dataConfirm: AllBookingViewEntity?
    private var dataFilter: AllBookingViewEntity?
    private let userId = UserDefaults.standard.integer(forKey: NameConstant.UserDefaults.userID)
    let attrs = [
        NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: UIScreen.main.bounds.width / 19)!
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        listBookingTableView.estimatedRowHeight = 50.0
        listBookingTableView.rowHeight = UITableView.automaticDimension
        contentSizeObservation = listBookingTableView.observe(\UITableView.contentSize, options: [.new]) { (_, change) in
            if let newSize = change.newValue {
                self.heightTBV.constant = newSize.height
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllData()
        navigationController?.isNavigationBarHidden = false
      //  UINavigationBar.appearance().titleTextAttributes = attrs
    }
}
// MARK: - Setup UI
extension AllBookingViewController {
    private func setupUI() {
        setupView()
        setupTableView()
        configureUI()
        dateTimeFormat()
    }
    func setupTableView() {
        listBookingTableView.registerCellNib(type: BookingsCell.self)
        listBookingTableView.dataSource = self
        listBookingTableView.delegate = self
    }
    private func setupView() {
        btnStartDate.dropShadowWithCornerRaduis(corlor: UIColor.white)
        btnEndDateDate.dropShadowWithCornerRaduis(corlor: UIColor.white)
        btnStartDate.titleLabel?.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoRegular.rawValue)
        btnEndDateDate.titleLabel?.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoRegular.rawValue)
        btnEndDateDate.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
        //  viewBlurBottom.dropShadowView(color: .white, opacity: 0.5, offSet: CGSize(width: 0, height: 0), radius: viewBlurBottom.frame.height / 2, scale: true)
    }
    func dateTimeFormat() {
        dateFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ss.SSSZ"
        dateFormatterPrint.dateFormat = "yyyy-dd-MM HH:mm"
        dateFormatterPrintDay.dateFormat = "yyyy-dd-MM"
    }
    func configureUI() {
        //        view.backgroundColor = .white
//        searchBarItem.sizeToFit()
//        searchBarItem.delegate = self
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.View.Red ?? UIColor.red]
        navigationController?.navigationBar.barTintColor = AppColor.View.White
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = AppColor.View.Red
        navigationController?.navigationBar.barStyle = .black
    //    navigationController?.navigationItem.titleView?.tintColor = AppColor.View.White
        navigationController?.navigationBar.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(0.4), width: 0.3)
        let rightItem = UIBarButtonItem(
            title: "Lọc",
            style: .plain,
            target: self,
            action: #selector(fillterButton))
        navigationItem.rightBarButtonItem = rightItem
//        rightItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Font.FontName.RobotoRegular.rawValue, size: widthScreen / 25)!], for: .normal)
        self.navigationController?.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Font.FontName.RobotoRegular.rawValue, size: 4)!], for: .normal)
    
        let leftItem = UIBarButtonItem(
            title: "Tất cả",
            style: .plain,
            target: self,
            action: #selector(allButton)
        )
//        leftItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Font.FontName.RobotoRegular.rawValue, size: widthScreen / 25)!], for: .normal)
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.title = "Đơn đặt"
    }
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

// MARK: - Handle Action
extension AllBookingViewController {
    @objc
    private func fillterButton() {
        fillterData()
    }
    @objc
    private func allButton() {
        getAllData()
    }
    private func fillterData() {

        model?.getListBook(idStore: userId, startDate: "\(self.dateFormatterPrintDay.string(from: self.dateFrom))", endDate: "\(self.dateFormatterPrintDay.string(from: self.dateTo))") { [weak self] result in

            switch result {
            case .success(let data):
                self?.data = data
                print(data)
                DispatchQueue.main.async {
                    self?.listBookingTableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
    private func getAllData() {
        model?.getListBookAll(idStore: userId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                print(data)
                DispatchQueue.main.async {
                    self?.listBookingTableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
    @IBAction func chooseStartDate(_ sender: Any) {
        let vc = DateViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.dateToSelected = dateTo
        vc.checkBtnDateFrom = 1
        self.present(vc, animated: true)
        // set date booking
        vc.didSendData = { [weak self] datePicked in
            guard self != nil else {
                return
            }
            self?.dateFrom = datePicked
            let dateString = "\(self!.dateFormatterPrint.string(from: self!.dateFrom))"
            self?.btnStartDate.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func chooseEndDate(_ sender: Any) {
        let vc = DateViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.dateFromSelected = dateFrom
        vc.checkBtnDateFrom = 2
        self.present(vc, animated: true)
        
        // set date booking
        vc.didSendData = { [weak self] datePicked in
            guard self != nil else {
                return
            }
            self?.dateTo = datePicked
            let dateString = "\(self!.dateFormatterPrint.string(from: self!.dateTo))"
            self?.btnEndDateDate.setTitle(dateString, for: .normal)
        }
    }
    func ApproveFunc(indexPath: IndexPath) {
        if let dataDele = data {
            model?.confirmBooking(idStore: userId, booking: dataDele.listData[indexPath.row].bookingId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataConfirm = data
                self?.data?.listData.remove(at: indexPath.row)
                self?.listBookingTableView.beginUpdates()
                self?.listBookingTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .left)
                self?.listBookingTableView.endUpdates()
                DispatchQueue.main.async {
                    
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
        }
    }
    func rejectFunc(indexPath: IndexPath) {
        if let dataDele = data {
            self.model?.deleteBooking(idBooking: dataDele.listData[indexPath.row].bookingId) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.dataDelete = data
                    print(data)
                    DispatchQueue.main.async {
                    }
                    self?.data?.listData.remove(at: indexPath.row)
                    self?.listBookingTableView.beginUpdates()
                    self?.listBookingTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .left)
                    self?.listBookingTableView.endUpdates()
                case .failure(let error):
                    self?.showAlert(message: "\(error)")
                }
            }
        }
      
    }
}
extension AllBookingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.listData.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: BookingsCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        cell.viewController = self
        cell.delegate = self
        if let data = data {
            cell.config(data: data.listData[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = data {
            let vc = UIStoryboard(name: NameConstant.Storyboard.AB, bundle: nil).instantiateVC(PopUpViewController.self)
            vc.data = data.listData[indexPath.row].serviceDTOList
            vc.modalPresentationStyle = .overFullScreen
            let transition = CATransition()
               transition.duration = 0.5
               transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
               transition.type = CATransitionType.moveIn
               transition.subtype = CATransitionSubtype.fromTop
                vc.view.layer.add(transition, forKey: nil)
             //  self.navigationController?.view.layer.add(transition, forKey: nil)
            self.present(vc, animated: true, completion: nil)
           //    self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Approve = UITableViewRowAction(style: .normal, title: "Hoàn thành") { _, _ in
            self.ApproveFunc(indexPath: indexPath)
        }
        Approve.backgroundColor = .green
        let Reject = UITableViewRowAction(style: .normal, title: "Huỷ") { _, _ in
            
            self.rejectFunc(indexPath: indexPath)
        }
        Reject.backgroundColor = .red
        return [Reject, Approve]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(rotationAngle: 360)
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.transform = CGAffineTransform(rotationAngle: 0.0)
        })
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
 
}
extension AllBookingViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        search(show: false)
    }
}
extension AllBookingViewController: confirmBookingProtocol {
    func confirm(data: AllBookingViewEntity.Role1ListBooking, idBooking: Int, senderr: UIButton) {
        model?.confirmBooking(idStore: userId, booking: idBooking) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataConfirm = data
                print(data)
                let point1 = senderr.convert(CGPoint.zero, to: self?.listBookingTableView)
                guard let indexpath = self?.listBookingTableView.indexPathForRow(at: point1) else {
                    return
                }
                self?.data?.listData.remove(at: indexpath.row)
                self?.listBookingTableView.beginUpdates()
                self?.listBookingTableView.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
                self?.listBookingTableView.endUpdates()
                DispatchQueue.main.async {
                    
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
    
//    func confirm(data: AllBookingViewEntity.Role1ListBooking, idBooking: Int) {
//        model?.confirmBooking(idStore: 1, booking: idBooking) { [weak self] result in
//            switch result {
//            case .success(let data):
//                self?.data = data
//                print(data)
//                DispatchQueue.main.async {
//                  //  self?.listBookingTableView.reloadData()
//                }
//            case .failure(let error):
//                self?.showAlert(message: "\(error)")
//            }
//        }
//    }
    
    func deleteBooking(idBooking: Int, senderr: UIButton) {
            self.model?.deleteBooking(idBooking: idBooking) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.dataDelete = data
                    print(data)
                    DispatchQueue.main.async {
                    }
                    let point = senderr.convert(CGPoint.zero, to: self?.listBookingTableView)
                    guard let indexpath = self?.listBookingTableView.indexPathForRow(at: point) else {
                        return
                    }
                    self?.data?.listData.remove(at: indexpath.row)
                    self?.listBookingTableView.beginUpdates()
                    self?.listBookingTableView.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
                    self?.listBookingTableView.endUpdates()
                case .failure(let error):
                    self?.showAlert(message: "\(error)")
                }
            }
    }

}
extension AllBookingViewController: AllBookingControllerProtocol {
    func set(model: AllBookingContract.Model) {
        self.model = model
    }
}
