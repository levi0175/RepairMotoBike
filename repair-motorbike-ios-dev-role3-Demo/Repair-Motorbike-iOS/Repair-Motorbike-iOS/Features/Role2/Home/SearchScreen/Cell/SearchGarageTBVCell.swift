//
//  searchGarageTBVCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 02/05/2022.
//

import UIKit
class SearchGarageTBVCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var imageGarage: UIImageView!
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var nameGarage: UILabel!
    @IBOutlet private weak var phone: UILabel!
    @IBOutlet private weak var numberVote: UILabel!
    @IBOutlet private weak var address: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containView.dropShadowWithCornerRaduis(corlor: UIColor.white)
        containView.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
        nameGarage.setSizeFont1(sizeFont: 23, font1: Font.FontName.RobotoMedium.rawValue)
        phone.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        numberVote.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        address.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        imageGarage.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(data: HomeGarageViewEntity.ListGarage1) {
        nameGarage.text = data.name
        phone.text = data.phone
        address.text = data.address
        numberVote.text = String(data.serviceList.count)
    }
    
}
