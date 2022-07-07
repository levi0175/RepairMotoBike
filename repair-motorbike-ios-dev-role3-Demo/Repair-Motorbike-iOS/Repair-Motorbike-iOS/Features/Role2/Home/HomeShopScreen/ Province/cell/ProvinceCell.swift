//
//  ProvinceCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 16/05/2022.
//

import UIKit

class ProvinceCell: UITableViewCell {

    @IBOutlet private weak var provinceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(data: ProvinceeViewEntity.ListProvince) {
        provinceLabel.text = data.list.name
    }
    
}
