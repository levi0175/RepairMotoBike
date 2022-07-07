//
//  ServiceListTableViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 05/06/2022.
//

import UIKit

class ServiceListTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var viewImage: UIImageView!
    @IBOutlet private weak var containView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containView.dropShadowWithCornerRaduis(corlor: UIColor.white)
        containView.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
        viewImage.layer.cornerRadius = viewImage.frame.width / 2
        viewImage.clipsToBounds = true
    }
    func config(data: AllBookingViewEntity.ListServiceAPI) {
        nameLabel.text = data.name
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
