//
//  ScheduleViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 07/05/2022.
//

import UIKit
final class ScheduleViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    @IBOutlet private weak var tabView: UITabViewCommon!
    @IBOutlet private weak var ScheduleCollectonView: UICollectionView!
    
    // MARK: - Variables
    private var nextBtn = 0
    private var model: ScheduleContract.Model?
    private var data: ScheduleViewEntity?
    private var dataSuccess: ScheduleViewEntity?
    private let userId = UserDefaults.standard.integer(forKey: NameConstant.UserDefaults.userID)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model?.getListBooked(userId: userId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                print(data)
                DispatchQueue.main.async {
                    self?.ScheduleCollectonView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
        model?.getListBookedSuccess(userId: userId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataSuccess = data
                print(data)
                DispatchQueue.main.async {
                    self?.ScheduleCollectonView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false

    }
    func getID(id: Int) {
        nextBtn = id
        ScheduleCollectonView.reloadData()

    }
}

// MARK: - Setup UI
extension ScheduleViewController {
    private func setupUI() {
        setupCollectonView()
        setupView()
        setVoteView()
        setupNavi()
    }
    
    private func setupNavi() {

        naviBar.addBorder(side: .bottom, color: .lightText, width: 0.3)
        naviBar.configData(title: NameConstant.Schedule.lich)
       // naviBar.setRedButton()
        naviBar.hiddenSave()
        naviBar.hiddenBack()
        naviBar.tappedBack {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupCollectonView() {
        ScheduleCollectonView.delegate = self
        ScheduleCollectonView.dataSource = self
        ScheduleCollectonView.registerCellNib1(type: ScheduleCollectionView.self)
    }
    
    private func setupView() {
        tabView.delegate = self
        tabView.textLeft = NameConstant.Schedule.scheduled
        tabView.textBottom = NameConstant.Schedule.complete
        tabView.textRight = NameConstant.Schedule.canceled

        tabView.addBorder(side: .bottom, color: .lightGray, width: 0.3)

    }
    
    private func setVoteView() {
        nextBtn = 0
        tabView.type = .right
    }
//    func getID(id: Int) {
//        nextBtn = id
//        ScheduleCollectonView.reloadData()
//    }
}

// MARK: - Handle Action
extension ScheduleViewController {
}
// MARK: - Setup CollectionView
extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellNib(type: ScheduleCollectionView.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.config(data: nextBtn)
        if let data = data {
            if let dataSuccess = dataSuccess {
                cell.passData(booked: data, success: dataSuccess)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeSlider = ScheduleCollectonView.frame.size
        return CGSize(width: sizeSlider.width, height: sizeSlider.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}
extension ScheduleViewController: ScheduleControllerProtocol {
    func set(model: ScheduleContract.Model) {
        self.model = model
    }
}
extension ScheduleViewController: getDataFromCellToScheduleProtocol {
    
    func getDataToBooking(data: ScheduleViewEntity.ListBooked) {
        let vc = UIStoryboard(name: NameConstant.Storyboard.DetailBook, bundle: nil).instantiateVC(DetailBookViewController.self)
        vc.dataBooked = data
        vc.checkVC = 1
        vc.statusBooking = NameConstant.Schedule.scheduled
        vc.set(model: DetailBookModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getDataSuccessToBooking(dataSuccess: ScheduleViewEntity.ListBookedSuccess) {
        let vc = UIStoryboard(name: NameConstant.Storyboard.DetailBook, bundle: nil).instantiateVC(DetailBookViewController.self)
        vc.dataSuccessBookSuccess = dataSuccess
        vc.checkVC = 2
        vc.statusBooking = NameConstant.Schedule.complete
        vc.set(model: DetailBookModel())
        navigationController?.pushViewController(vc, animated: true)

    }
}
extension ScheduleViewController: delegateTabViewHome {
    func handleChangeTabView(with type: UITabViewCommon.TypeTab) {
        if type == .left {
            getID(id: 1)
            tabView.type = .left
        } else if type == .bottom {
            getID(id: 2)
            tabView.type = .bottom
        } else {
            getID(id: 0)
            tabView.type = .right
        }
    }
    
}
