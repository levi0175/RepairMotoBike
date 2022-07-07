//
//  UserSettingCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 29/04/2022.
//

import UIKit

class UserSettingCell: UITableViewCell {

    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var labelPhone: UILabel!
    @IBOutlet private weak var imgNext: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        labelPhone.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupData(_ image: String, name: String) {
        iconImage.image = UIImage(named: image)
        labelName.text = name
    }
    
    func showPhone(data: SettingViewEntity) {
         labelPhone.text = data.data?.phone
        labelPhone.isHidden = false
        imgNext.isHidden = true
    }
    func hidePhone() {
        labelPhone.isHidden = true
        imgNext.isHidden = false
    }
}
