//
//  ScheduleCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 10/05/2022.
//

import UIKit

class ScheduleCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameGarage: UILabel!
    @IBOutlet private weak var dateCreate: UILabel!
    @IBOutlet private weak var addressGarage: UILabel!
    @IBOutlet private weak var dateCreateTit: UILabel!
    @IBOutlet private weak var addressGarageTit: UILabel!
    @IBOutlet private weak var contentViewCell: UIView!
    
    private let dateFormatter = DateFormatter()
    private let dateFormatterPrint = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameGarage.setSizeFont1(sizeFont: 23, font1: Font.FontName.RobotoMedium.rawValue)
        dateCreate.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        addressGarage.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        dateCreateTit.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        addressGarageTit.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatterPrint.dateFormat = "yyyy-dd-MM HH:mm"
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        contentViewCell.dropShadowWithCornerRaduis(corlor: UIColor.white)
        contentViewCell.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
    }
    func config(data: ScheduleViewEntity.ListBooked) {
        nameGarage.text = data.storeName
        addressGarage.text = data.phoneUser
        if let date = dateFormatter.date(from: data.timeRepair ?? "") {
            dateCreate.text = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
       // dateCreate.text = "\(dateFormatter.string(from: data.timeRepair?.toDate(.isoDate) ?? Date()))"
    }
    func configSuccess(data1: ScheduleViewEntity.ListBookedSuccess) {
        nameGarage.text = data1.storeName
        addressGarage.text = data1.phoneUser
        if let date = dateFormatter.date(from: data1.timeRepair ?? "") {
            dateCreate.text = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        // dateCreate.text = "\(dateFormatter.string(from: data1.timeRepair?.toDate(.localDateTimeSec) ?? Date()))"
    }
}
