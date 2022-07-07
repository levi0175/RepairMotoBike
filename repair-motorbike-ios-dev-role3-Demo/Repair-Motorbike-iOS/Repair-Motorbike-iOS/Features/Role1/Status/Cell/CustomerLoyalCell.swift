//
//  CustomerLoyalCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 20/05/2022.
//

import UIKit

class CustomerLoyalCell: UITableViewCell {
    @IBOutlet private weak var imageBackGround: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var numberPhoneLabel: UILabel!
    @IBOutlet private weak var numberBillLabel: UILabel!
    @IBOutlet private weak var numberPhoneLabelTit: UILabel!
    @IBOutlet private weak var numberBillLabelTit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setSize()
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 0))
    }
    func setSize() {
        nameLabel.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoMedium.rawValue)
        numberPhoneLabel.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        numberBillLabel.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        numberPhoneLabelTit.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        numberBillLabelTit.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        imageBackGround.dropShadowWithCornerRaduis(corlor: UIColor.white)
        imageBackGround.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
    }
    func config(data: CustomerLoyalViewEntity.ListUserLoyal) {
        nameLabel.text = data.name
        numberPhoneLabel.text = data.phone
        numberBillLabel.text = String(data.billList.count)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
