//
//  ScheduleCollectionView.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 15/05/2022.
//

import UIKit
protocol getDataFromCellToScheduleProtocol: AnyObject {
    func getDataToBooking(data: ScheduleViewEntity.ListBooked)
    func getDataSuccessToBooking(dataSuccess: ScheduleViewEntity.ListBookedSuccess)
}
class ScheduleCollectionView: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var ScheduleCollectonViewParent: UICollectionView!
    weak var delegate: getDataFromCellToScheduleProtocol?
    weak var delegateSuccess: getDataFromCellToScheduleProtocol?
    // MARK: - Variables
     var nextBtn = 0
    private var listDataBooked: ScheduleViewEntity?
    private var listDataBookedSuccess: ScheduleViewEntity?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectonView()
    }
    
    private func setupUI() {
        setupCollectonView()
    }
    func config(data: Int) {
        nextBtn = data
        print(" aaaaaaa\(data)")
        ScheduleCollectonViewParent.reloadData()
    }
    func passData(booked: ScheduleViewEntity, success: ScheduleViewEntity) {
        listDataBooked = booked
        listDataBookedSuccess = success

        ScheduleCollectonViewParent.reloadData()
    }
    
    private func setupCollectonView() {
        ScheduleCollectonViewParent.delegate = self
        ScheduleCollectonViewParent.dataSource = self
        ScheduleCollectonViewParent.registerCellNib1(type: ScheduleCell.self)
    }
}
// MARK: - Setup CollectionView
extension ScheduleCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if nextBtn == 0 {
            return listDataBooked?.data.count ?? 0
        } else if nextBtn == 1 {
            return listDataBookedSuccess?.dataSuccess.count ?? 0
        } else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellNib(type: ScheduleCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
            if nextBtn == 0 {
                if var listDataBooked = listDataBooked {
                    listDataBooked.data.reverse()
                    cell.layer.cornerRadius = 10
                    cell.config(data: listDataBooked.data[indexPath.row])
                }
            } else if nextBtn == 1 {
                if var listDataBookedSuccess = listDataBookedSuccess {
                    listDataBookedSuccess.dataSuccess.reverse()
                    cell.configSuccess(data1: listDataBookedSuccess.dataSuccess[indexPath.row])
                }
            } else {
                if let listDataBookedSuccess = listDataBookedSuccess {
                    cell.config(data: listDataBookedSuccess.data[indexPath.row])
                }
            }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if nextBtn == 0 {
            if let listDataBooked = listDataBooked {
                delegate?.getDataToBooking(data: listDataBooked.data[indexPath.row])
            }
        } else if nextBtn == 1 {
            if let listDataBookedSuccess = listDataBookedSuccess {
                delegate?.getDataSuccessToBooking(dataSuccess: listDataBookedSuccess.dataSuccess[indexPath.row])
            }
        } else {
           
        }
    }
}

extension ScheduleCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeSlider = ScheduleCollectonViewParent.frame.size
        return CGSize(width: sizeSlider.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}
