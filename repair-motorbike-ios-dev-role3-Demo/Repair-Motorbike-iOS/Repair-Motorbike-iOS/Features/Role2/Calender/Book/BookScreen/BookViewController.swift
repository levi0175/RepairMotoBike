//  
//  BookViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 26/04/2022.
//

import UIKit
protocol DelegateBookView: AnyObject {
    func didSelectDetail(nameGara: String, sdtGara: String, diaCiGara: String, nameKhach: String, sdtKhach: String, ngayDat: String, timeKhach: String, loaiXe: String, bienSo: String )
}

final class BookViewController: BaseViewController {
    
    @IBOutlet weak private var view1: UIView!
    @IBOutlet weak private var view3: UIView!
    @IBOutlet weak private var view2: UIView!
    @IBOutlet weak private var btnBack: UIButton!
    @IBOutlet weak private var btnNext: UIButton!
    @IBOutlet weak private var viewLine2: UIView!
    @IBOutlet weak private var viewLine1: UIView!
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet private weak var bookCollectionVIew: UICollectionView!
    
    private var model: BookContract.Model?
    var count: Int = 0
    var currentVC: UIViewController?
    var storeOriginY: CGFloat = 0
    var receivedString = ""
    private var data: BookViewEntity = BookViewEntity()
    var listData: HomeGarageViewEntity.ListGarage1?
    var listDataDetailShop: [HomeGarageViewEntity.ServiceListGaraHung] = []
    var listDataDetailShop1: [HomeGarageViewEntity.ServiceListGaraHung] = []
    var listServiceFromSearch: [HomeGarageViewEntity.ServiceListGaraHung] = []
    var didSelectHomVC: Int = -1
    var checkStore: Bool = false
    var check1: Bool = false
    var checkDate: Bool = false
    var checkSearch: Bool = false
    var dateFrom = Date()
    var dateTo = Date()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    var name: String = ""
    var sdt: String = ""
    var bienSo: String = ""
    var nameShop: String = ""
    var ngayHen: String = ""
    var thoiGian: String = ""
    var sdtShop: String = ""
    var diaChiShop: String = ""
    weak var delegate: DelegateBookView?
    private var model1: BookContract.Model?
    var dataUser: BookViewEntity?
    // weak var delegate: DelegateBookView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        setUpView()
        setupViewDefault()
        count = 0
        setupCollectionview()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        timeFormatter.dateFormat = "HH:mm"
        getData()
        self.tappedHideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       
    }
    @objc
    func keyboardWillShow(sender: NSNotification) {
        self.contentView.frame.origin.y = 0
       
    }
    @objc
    func keyboardWillHide(sender: NSNotification) {
        self.contentView.frame.origin.y = 0
        
    }
}

// MARK: - Setup UI
extension BookViewController {
    private func setupUI() {
        tabBarController?.tabBar.isHidden = true

        btnBack.layer.cornerRadius = 10
        btnNext.layer.cornerRadius = 10
    }
    private func getData() {
        let userId = UserDefaults.standard.integer(forKey: NameConstant.UserDefaults.userID)
        model?.getUser(id: userId) { result in
            switch result {
            case .success(let data):
                self.dataUser = data
            case .failure(let error):
                print(error)
            }
        }
    }

    private func setupCollectionview() {
        bookCollectionVIew.registerCellNib1(type: BookStep1CLVCell.self)
        bookCollectionVIew.registerCellNib1(type: Step2CollectionViewCell.self)
        bookCollectionVIew.registerCellNib1(type: Step3CollectionViewCell.self)
        bookCollectionVIew.delegate = self
        bookCollectionVIew.dataSource = self
        bookCollectionVIew.isPagingEnabled = true
        if let flowLayout = bookCollectionVIew.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
    }
   
    func setUpView() {
        viewLine2.backgroundColor = AppColor.View.noSelect
        viewLine1.backgroundColor = AppColor.View.noSelect
        view1.layer.cornerRadius = view1.frame.width / 2
        view2.layer.cornerRadius = view1.frame.width / 2
        view3.layer.cornerRadius = view1.frame.width / 2
    }
    func setupViewDefault() {
        view1.backgroundColor = AppColor.View.yellowSelect
        view2.backgroundColor = AppColor.View.noSelect
        view3.backgroundColor = AppColor.View.noSelect
        viewLine1.backgroundColor = AppColor.View.noSelect
        viewLine2.backgroundColor = AppColor.View.noSelect
        btnBack.isHidden = true
    }
    
}

// MARK: - Handle Action
extension BookViewController {
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionBackAndNext(_ sender: Any) {
        guard let tag = (sender as AnyObject).tag else {
            return
        }
        if checkDate == true && checkStore == true {
        switch (tag, count) {
               
        case (0, 0):
                setupViewDefault()
                handlescrollMenuItemIndex(menuIndex: count)
               
        case (0, 1):
                setupViewDefault()
                count = 0
                handlescrollMenuItemIndex(menuIndex: count)
        case (0, 2):
                viewLine1.backgroundColor = AppColor.View.yellowSelect
                viewLine2.backgroundColor = AppColor.View.noSelect
                view1.backgroundColor = AppColor.View.yellowSelect
                view2.backgroundColor = AppColor.View.yellowSelect
                view3.backgroundColor = AppColor.View.noSelect
                count = 1
                btnBack.isHidden = false
                handlescrollMenuItemIndex(menuIndex: count)
        case (1, 0):
                
                viewLine1.backgroundColor = AppColor.View.yellowSelect
                viewLine2.backgroundColor = AppColor.View.noSelect
                view1.backgroundColor = AppColor.View.yellowSelect
                view2.backgroundColor = AppColor.View.yellowSelect
                view3.backgroundColor = AppColor.View.noSelect
                count = 1
                btnBack.isHidden = false
                handlescrollMenuItemIndex(menuIndex: count)
        case (1, 1):
                viewLine1.backgroundColor = AppColor.View.yellowSelect
                viewLine2.backgroundColor = AppColor.View.yellowSelect
                view1.backgroundColor = AppColor.View.yellowSelect
                view2.backgroundColor = AppColor.View.yellowSelect
                view3.backgroundColor = AppColor.View.yellowSelect
                count = 2
                btnBack.isHidden = false
                handlescrollMenuItemIndex(menuIndex: count)
        case (1, 2):
                let vc = UIStoryboard(name: NameConstant.Storyboard.DetailBook, bundle: nil).instantiateVC(DetailBookViewController.self)

                guard let cell3 = self.bookCollectionVIew?.cellForItem(at: IndexPath(row: 2, section: 0)) as? Step3CollectionViewCell else {
                    return
                }
                cell3.delegate = self
                cell3.delegateText()
                vc.dataUser = dataUser
                vc.name = name
                vc.soDT = sdt
                vc.bienSo = bienSo
                vc.nameGara = nameShop
                vc.ngayDat = ngayHen
                vc.thoiGian = thoiGian
                vc.diaChiShop = diaChiShop
                vc.sdtShop = sdtShop
                vc.idStore = listData?.storeId ?? 1

                vc.listDataDetailShop1 = listDataDetailShop1

                vc.statusBooking = "Đang đặt..."
                vc.set(model: DetailBookModel())
               
                navigationController?.pushViewController(vc, animated: true)
                
        default:
            break
        }
        } else {
             let alert = UIAlertController(title: "Error", message: "Please fill information", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
         }
        
    }
    func delegateDetail() {
        
    }
    func handlescrollMenuItemIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        bookCollectionVIew.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
    }
}

extension BookViewController: BookControllerProtocol {
    func set(model: BookContract.Model) {
        self.model = model
    }
}
extension BookViewController: UICollectionViewDelegate {
    
}
extension BookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
                guard let cell = collectionView.dequeueReusableCellNib(type: BookStep1CLVCell.self, for: indexPath) else {
                    return UICollectionViewCell()
                }

                cell.delegate = self
                cell.config(nameShope: listData?.name ?? "")
               
                nameShop = listData?.name ?? ""
                diaChiShop = listData?.address ?? ""
                sdtShop = listData?.phone ?? ""
              
            return cell
        case 1:
                guard let cell = collectionView.dequeueReusableCellNib(type: Step2CollectionViewCell.self, for: indexPath) else {
                return UICollectionViewCell()
            }
                cell.configCha(ListFromSearch: listDataDetailShop, check: true)
                cell.delegate = self
            return cell
        case 2:
                guard let cell = collectionView.dequeueReusableCellNib(type: Step3CollectionViewCell.self, for: indexPath) else {
                    return UICollectionViewCell()
                }
            if let dataUser = dataUser {
                cell.config(ten: dataUser.data?.name ?? "", sdt: dataUser.data?.phone ?? "")
            }
            return cell
        default:
                break
        }
        return UICollectionViewCell()
    }
}
extension BookViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: bookCollectionVIew.frame.width, height: bookCollectionVIew.frame.height)
    }
}

extension BookViewController: DelegateStep1 {
    func didSelectChoseDate() {
        checkDate = true
        let vc = DateViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        vc.dateFromSelected = dateTo
        vc.checkBtnDateFrom = 0
        parent?.present(vc, animated: false, completion: nil)
        
        vc.didSendData = { [weak self] datePicked in
            guard self != nil else {
                return
                
            }
            self?.dateFrom = datePicked
            let dateString = "\(self!.dateFormatter.string(from: self!.dateFrom))"
            let timeString = "\(self!.timeFormatter.string(from: self!.dateFrom))"
            guard let cell = self?.bookCollectionVIew?.cellForItem(at: IndexPath(row: 0, section: 0)) as? BookStep1CLVCell else {
                return
            }
            cell.configDate(ngayHen: dateString, gioHen: timeString)
            self?.ngayHen = dateString
            self?.thoiGian = timeString
        }
    }
    
    func didSelectSearchStore() {
       // let parent = parentCell as? BookViewController
        checkStore = true
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(SearchViewController.self)
        detailView.set(model: SearchModel())
        detailView.check = true
        detailView.handleChange = { [weak self] data in
            guard self != nil else {
                return
                
            }

            guard let cell = self?.bookCollectionVIew?.cellForItem(at: IndexPath(row: 0, section: 0)) as? BookStep1CLVCell else {
                return
            }
            
            cell.config(nameShope: data.search.name ?? "")
            self?.nameShop = data.search.name ?? ""
            self?.diaChiShop = data.search.address ?? ""
            self?.sdtShop = data.search.phone ?? ""
            self?.listDataDetailShop = data.search.serviceList
            print(data.search.serviceList)
            
        }
        let navController = UINavigationController(rootViewController: detailView)
        present(navController, animated: true, completion: nil)
    }
    
}
extension BookViewController: DelegateStep2 {
    func DelegateStep2(list: [HomeGarageViewEntity.ServiceListGaraHung], check: Bool) {
        listDataDetailShop1 = list
        check1 = check
    }
 
}
extension BookViewController: DelegatetStep3 {
    func didSelectText(nhapTen: String, nhapSDT: String, NhapBS: String) {
        
        name = nhapTen
        sdt = nhapSDT
        bienSo = NhapBS
    }
}
