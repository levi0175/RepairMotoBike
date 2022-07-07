//
//  ServiceTBVCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 28/05/2022.
//

import UIKit

class ServiceTBVCell: UITableViewCell {
    @IBOutlet private weak var nameServiceLbl: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var containView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containView.dropShadowWithCornerRaduis(corlor: UIColor.white)
        containView.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configService(data: DetailShopViewEntity.ListShop) {
      //  containView.layer.cornerRadius = 5
        
        nameServiceLbl.setSizeFont1(sizeFont: 25, font1: Font.FontName.RobotoRegular.rawValue)
        price.setSizeFont1(sizeFont: 25, font1: Font.FontName.RobotoRegular.rawValue)
        nameServiceLbl.text = data.name
        price.text = "Giá: \(data.price) Đ"
    }
}
