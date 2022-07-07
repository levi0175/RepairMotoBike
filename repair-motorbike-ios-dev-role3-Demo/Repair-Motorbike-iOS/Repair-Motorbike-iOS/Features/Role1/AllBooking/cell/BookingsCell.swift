//
//  BookingsCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 18/05/2022.
//

import UIKit
protocol confirmBookingProtocol: AnyObject {
    func confirm(data: AllBookingViewEntity.Role1ListBooking, idBooking: Int, senderr: UIButton)
    func deleteBooking(idBooking: Int, senderr: UIButton)
}
class BookingsCell: UITableViewCell {   
    @IBOutlet private weak var imageBackGround: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var numberLabelTitle: UILabel!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var dateLabelTitle: UILabel!
    @IBOutlet private weak var statusTitle: UILabel!
    @IBOutlet private weak var buttonSuccess: UIButton!
    @IBOutlet private weak var buttonDelete: UIButton!
    private let dateFormatter = DateFormatter()
    private let dateFormatterPrint = DateFormatter()
    weak var viewController: UIViewController?
    private var dataBooking: AllBookingViewEntity.Role1ListBooking?
    weak var delegate: confirmBookingProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ss.SSSZ"
        dateFormatterPrint.dateFormat = "yyyy-dd-MM HH:mm"
        imageBackGround.layer.cornerRadius = 10
        nameLabel.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoMedium.rawValue)
        dateLabel.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        numberLabel.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        numberLabelTitle.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        status.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        dateLabelTitle.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        statusTitle.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        imageBackGround.dropShadowWithCornerRaduis(corlor: UIColor.white)
        imageBackGround.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
    }
    @IBAction func deleteBooking(_ sender: UIButton) {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn chắn chắn muốn huỷ lịch đặt", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { _ in
            if let dataBooking = self.dataBooking {
                self.delegate?.deleteBooking(idBooking: dataBooking.bookingId, senderr: sender)
            }
        }))
        alert.addAction(UIAlertAction(title: "Huỷ", style: UIAlertAction.Style.cancel, handler: { _ in
        }))
        viewController?.present(alert, animated: true, completion: nil)
    
    }
    @IBAction func confirmBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Thông báo", message: "Xác nhận hoàn thành đơn", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { _ in
            if let dataBooking = self.dataBooking {
                self.delegate?.confirm(data: dataBooking, idBooking: dataBooking.bookingId, senderr: sender)
            }
        }))
        alert.addAction(UIAlertAction(title: "Huỷ", style: UIAlertAction.Style.cancel, handler: { _ in
        }))
        viewController?.present(alert, animated: true, completion: nil)
    }
    func config(data: AllBookingViewEntity.Role1ListBooking) {
            dataBooking = data
            nameLabel.text = data.userName
            numberLabel.text = data.phoneUser
        if let date = dateFormatter.date(from: data.timeRepair ?? "") {
            dateLabel.text = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
