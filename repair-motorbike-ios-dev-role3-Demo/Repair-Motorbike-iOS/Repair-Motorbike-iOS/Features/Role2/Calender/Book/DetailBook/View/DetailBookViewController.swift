//
//  DetailBookViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 05/05/2022.
//

import UIKit

final class DetailBookViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet weak private var viewTop: UIView!
    @IBOutlet weak private var viewImage: UIView!
    @IBOutlet weak private var viewCancel: UIView!
    @IBOutlet weak private var viewBackMain: UIView!
    @IBOutlet private weak var lbthoiGian: UILabel!
    @IBOutlet private weak var lbTime: UILabel!
    @IBOutlet private weak var lbBienSo: UILabel!
    @IBOutlet private weak var lbtimer: UILabel!
    @IBOutlet private weak var lbSDTGuest: UILabel!
    @IBOutlet private weak var lbNameGuest: UILabel!
    @IBOutlet private weak var lbAddressGara: UILabel!
    @IBOutlet private weak var lbSDTGara: UILabel!
    @IBOutlet private weak var lbNameGara: UILabel!
    @IBOutlet private weak var lblStatusBooking: UILabel!
    @IBOutlet private weak var serviceTableView: UITableView!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var infoGaraView: UIView!
    @IBOutlet private weak var infoCustomerView: UIView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var buttonBook: UIButton!
    @IBOutlet private weak var buttonCancel: UIButton!
    
    @IBOutlet private weak var infoDriverView: UIView!
    public var handle:((_ nameGara: String, _ sdtGara: String, _ diaChiGara: String, _ nameKhach: String, _ sdtKhach: String, _ timeKhach: String, _ loaiXe: String, _ bienSo: String) -> Void)?
    // MARK: - Variables
    private var model: DetailBookContract.Model?
    var name: String = ""
    var soDT: String = ""
    var bienSo: String = ""
    var nameGara: String = ""
    var ngayDat: String = ""
    var thoiGian: String = ""
    var diaChiShop: String = ""
    var sdtShop: String = ""
    var statusBooking: String = ""
    var idStore: Int = 1
    var listDataDetailShop1: [HomeGarageViewEntity.ServiceListGaraHung] = []
    var dataUser: BookViewEntity?
    var data: DetailBookViewEntity?

    var da: [ListServiceAPIResponse] = []

    var arrayIdService: [ListServiceAPIResponse] = []
    var dataBooked: ScheduleViewEntity.ListBooked?
    var dataSuccessBookSuccess: ScheduleViewEntity.ListBookedSuccess?
    var checkVC = 0
    private let userIdd = UserDefaults.standard.integer(forKey: NameConstant.UserDefaults.userID)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpTableView()

        print("aa1 \(listDataDetailShop1)")
        indicator.isHidden = true
//        model?.booking(userName: "aa1", userPhone: "aa2", timeRepair: "2022-15-05", numberPlate: "aa3", services: []){ [weak self] result in
//            switch result {
//            case .success(let data):
//                self?.data = data
//                print(data)
//                DispatchQueue.main.async {
//             // self?.sliderTableView.reloadData()
//                }
//            case .failure(let error):
//                self?.showAlert(message: "\(error)")
//            }
//        }
    }

}

// MARK: - Setup UI
extension DetailBookViewController {
    private func setupUI() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.viewTop.frame
        rectShape.position = self.viewTop.center
        rectShape.path = UIBezierPath(roundedRect: self.viewTop.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        tabBarController?.tabBar.isHidden = true
        self.viewTop.layer.mask = rectShape
        
        viewImage.layer.cornerRadius = viewImage.frame.width / 2
        viewImage.clipsToBounds = true
        viewCancel.layer.cornerRadius = 10
        viewBackMain.layer.cornerRadius = 10
        viewCancel.setBorder(color: .black, width: 1)
        viewBackMain.setBorder(color: .red, width: 1)
        prinData()
        setupBorderBottom()
        lblStatusBooking.text = statusBooking
    }
    func prinData() {
        if checkVC == 0 {
            lbNameGuest.text = name
            lbSDTGuest.text = soDT
            lbBienSo.text = bienSo
            lbNameGara.text = nameGara
            lbTime.text = thoiGian
            lbthoiGian.text = ngayDat
            lbtimer.text = ngayDat
            lbSDTGara.text = sdtShop
            buttonBook.isHidden = false
            viewBackMain.isHidden = false

            lbAddressGara.text = diaChiShop
        } else if checkVC == 1 {
            lbNameGuest.text = dataBooked?.userName
            lbSDTGuest.text = dataBooked?.phoneUser
            lbBienSo.text = dataBooked?.numberPlate
            lbNameGara.text = dataBooked?.storeName
            lbTime.text = thoiGian
            lbthoiGian.text = ngayDat
            lbtimer.text = dataBooked?.timeRepair
            lbSDTGara.text = sdtShop
            lbAddressGara.text = diaChiShop
            buttonBook.isHidden = true
            viewBackMain.isHidden = true

            serviceTableView.reloadData()
            
        } else {
            lbNameGuest.text = dataSuccessBookSuccess?.userName
            lbSDTGuest.text = dataSuccessBookSuccess?.phoneUser
            lbBienSo.text = dataSuccessBookSuccess?.numberPlate
            lbNameGara.text = dataSuccessBookSuccess?.storeName
            lbTime.text = thoiGian
            lbthoiGian.text = ngayDat
            lbtimer.text = dataSuccessBookSuccess?.timeRepair
            lbSDTGara.text = sdtShop
            buttonBook.isHidden = true
            viewBackMain.isHidden = true

            lbAddressGara.text = diaChiShop
        }
    }
//    func setuplable() {
//        lbNameGuest.text = name
//        lbSDTGuest.text = soDT
//        lbBienSo.text = bienSo
//        lbNameGara.text = nameGara
//        lbTime.text = thoiGian
//        lbthoiGian.text = ngayDat
//        lbtimer.text = ngayDat
//        lbSDTGara.text = sdtShop
//        lbAddressGara.text = diaChiShop
//    }
    func setUpTableView() {
        serviceTableView.registerCellNib(type: ServiceTableViewCell.self)
        serviceTableView.delegate = self
        serviceTableView.dataSource = self
    }

    func setupBorderBottom() {
        topView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(0.5), width: 0.5)
        infoGaraView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(0.5), width: 0.5)
        infoCustomerView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(0.5), width: 0.5)
        infoDriverView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(0.5), width: 0.5)
    }

}

// MARK: - Handle Action
extension DetailBookViewController {
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDatHang(_ sender: Any) {
        if lbSDTGuest.text != "" {
            arrayIdService.removeAll()
            indicator.isHidden = false
            indicator.startAnimating()
            indicator.hidesWhenStopped = true
            for i in 0..<listDataDetailShop1.count {
                arrayIdService.append(ListServiceAPIResponse(serviceId: listDataDetailShop1[i].serviceId ?? 0))
            }
            model?.getListBooking(garaId: idStore, userId: userIdd, userName: lbNameGuest.text ?? "",

                                  userPhone: lbSDTGuest.text ?? "",
                                  timeRepair: lbthoiGian.text ?? "17/05/2022",
                                  numberPlate: lbAddressGara.text ?? "",
                                  services: arrayIdService) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.data = data
                    print(data)
                    DispatchQueue.main.async {
                    }
                        self?.indicator.stopAnimating()
                        self?.showAlertOK(message: "Đặt thành công")
                        let vc = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(HomeGarageViewController.self)
                        vc.set(model: HomeGarageModel())
                        self?.navigationController?.pushViewController(vc, animated: true)
                case .failure(let error):
                        self?.indicator.stopAnimating()
                    self?.showAlert(message: "\(error)")
                }
            }
        } else {
            let alert = UIAlertController(title: "Thông tin?", message: "Vui lòng nhập số điện thoại??", preferredStyle: UIAlertController.Style.alert)
                    // add the actions (buttons)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                        self.navigationController?.popViewController(animated: true)
                    }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func pop(_ sender: UIButton) {
        let alert = UIAlertController(title: "Hủy?", message: "Bạn có muốn hủy??", preferredStyle: UIAlertController.Style.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                // show the alert
        self.present(alert, animated: true, completion: nil)
       
    }
    @IBAction func backScreenMain(_ sender: UIButton) {
       print("ss")
    }
}

extension DetailBookViewController: DetailBookControllerProtocol {
    func set(model: DetailBookContract.Model) {
        self.model = model
    }
}
extension DetailBookViewController: DelegateBookView {
    func didSelectDetail(nameGara: String, sdtGara: String, diaCiGara: String, nameKhach: String, sdtKhach: String, ngayDat: String, timeKhach: String, loaiXe: String, bienSo: String) {
        lbNameGara?.text = nameGara
        lbNameGara?.text = nameKhach
    }
}
extension DetailBookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkVC == 0 {
          return listDataDetailShop1.count
        } else if checkVC == 1 {
            return dataBooked?.serviceDTOList.count ?? 0
        }
        return dataSuccessBookSuccess?.serviceDTOList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: ServiceTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        if checkVC == 0 {
            cell.config(count: String(indexPath.row + 1), list: listDataDetailShop1[indexPath.row].name ?? "")
        } else if checkVC == 1 {
            if let dataBooked = dataBooked {
                cell.config(count: String(indexPath.row + 1), list: dataBooked.serviceDTOList[indexPath.row].name ?? "Không có")
            }
        }
        if let dataSuccessBookSuccess = dataSuccessBookSuccess {
            cell.config(count: String(indexPath.row + 1), list: dataSuccessBookSuccess.serviceDTOList[indexPath.row].name ?? "Không có")
        }
        return cell
    }
}
