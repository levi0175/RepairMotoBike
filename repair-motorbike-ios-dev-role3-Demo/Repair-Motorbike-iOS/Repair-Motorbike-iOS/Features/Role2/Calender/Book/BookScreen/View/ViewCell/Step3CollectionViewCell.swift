//
//  Step3CollectionViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 21/05/2022.
//

import UIKit

protocol DelegatetStep3: AnyObject {
    func didSelectText(nhapTen: String, nhapSDT: String, NhapBS: String)
}

class Step3CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var txtNhapTen: UITextField!
    @IBOutlet private weak var txtNhapBienSo: UITextField!
    @IBOutlet private weak var txtNhapSDT: UITextField!
    
    weak var delegate: DelegatetStep3?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    func delegateText() {
        delegate?.didSelectText(nhapTen: txtNhapTen.text ?? "", nhapSDT: txtNhapSDT.text ?? "", NhapBS: txtNhapBienSo.text ?? "")
    }
    func config(ten: String, sdt: String) {
        txtNhapSDT.text = sdt
        txtNhapTen.text = ten
    }
}
extension Step3CollectionViewCell {
    private func setupUI() {
        txtNhapSDT.attributedPlaceholder = NSAttributedString(string: "Nhập số điện thoại", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtNhapTen.attributedPlaceholder = NSAttributedString(string: "Nhập tên", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtNhapBienSo.attributedPlaceholder = NSAttributedString(string: "Nhập biển số xe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
}

// MARK: - Handle Action
extension Step3CollectionViewCell {
   
}
