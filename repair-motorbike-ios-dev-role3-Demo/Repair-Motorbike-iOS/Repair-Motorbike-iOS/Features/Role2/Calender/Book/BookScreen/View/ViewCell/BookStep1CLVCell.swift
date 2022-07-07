//
//  BookStep1CLVCell.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 21/05/2022.
//

import UIKit

protocol DelegateStep1: AnyObject {
    func didSelectSearchStore()
    func didSelectChoseDate()
}

class BookStep1CLVCell: UICollectionViewCell {
    
    @IBOutlet private weak var viewGara: UIView!
    @IBOutlet private weak var viewNgayHen: UIView!
    @IBOutlet private weak var txtShop: UITextField!
    @IBOutlet private weak var viewThoiGian: UIView!
    @IBOutlet weak private var txtNgayHen: UITextField!
    @IBOutlet weak private var txtTime: UITextField!
    @IBOutlet private weak var btnChoseDate: UIButton!
    weak var delegate: DelegateStep1?
   
    override func awakeFromNib() {
        super.awakeFromNib()

       btnChoseDate.layer.cornerRadius = 10
        viewGara.addBorder(side: .bottom, color: .gray.withAlphaComponent(0.5), width: 1)
        viewNgayHen.addBorder(side: .bottom, color: .gray.withAlphaComponent(0.5), width: 1)
        viewThoiGian.addBorder(side: .bottom, color: .gray.withAlphaComponent(0.5), width: 1)
        txtNgayHen.attributedPlaceholder = NSAttributedString(string: "Chọn ngày đến", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtTime.attributedPlaceholder = NSAttributedString(string: "Chọn thời gian", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtShop.attributedPlaceholder = NSAttributedString(string: "Chọn gara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    func config(nameShope: String) {
        txtShop.text = nameShope

    }
    
    func configDate(ngayHen: String, gioHen: String) {
        txtNgayHen.text = ngayHen
        txtTime.text = gioHen
    }
    @IBAction func btnSearchStore(_ sender: Any) {
        delegate?.didSelectSearchStore()
        
}
    @IBAction func btnChoseDate(_ sender: UIButton) {
        delegate?.didSelectChoseDate()
    }
      
}
