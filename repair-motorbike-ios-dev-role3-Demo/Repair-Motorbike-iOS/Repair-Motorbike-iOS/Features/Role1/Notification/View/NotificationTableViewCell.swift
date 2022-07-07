//
//  NotificationTableViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 18/05/2022.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet private weak var ContainView: UIView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var lblPriceTit: UILabel!
    @IBOutlet private weak var imageViewShop: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewShop.layer.cornerRadius = imageViewShop.bounds.height / 2
        labelName.setSizeFont1(sizeFont: 22, font1: Font.FontName.RobotoMedium.rawValue)
        lblPrice.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        lblPriceTit.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        ContainView.dropShadowWithCornerRaduis(corlor: UIColor.white)
        ContainView.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
    }
    func setupData(data: DetailShopViewEntity.ListShop) {
        labelName.text = data.name
        lblPrice.text = String(data.price)
    }
}
