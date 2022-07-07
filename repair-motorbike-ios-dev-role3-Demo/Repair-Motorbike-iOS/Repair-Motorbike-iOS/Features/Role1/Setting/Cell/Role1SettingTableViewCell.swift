//
//  Role1SettingTableViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 07/06/2022.
//

import UIKit

class Role1SettingTableViewCell: UITableViewCell {
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var labelPhone: UILabel!
    @IBOutlet private weak var imgNext: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupData(_ image: String, name: String) {
        iconImage.image = UIImage(named: image)
        labelName.text = name
    }
    
    func showPhone(data: Role1SettingViewEntity) {
         labelPhone.text = data.data?.phone
        labelPhone.isHidden = false
        imgNext.isHidden = true
    }
    func hidePhone() {
        labelPhone.isHidden = true
        imgNext.isHidden = false
    }
    
}
