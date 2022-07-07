//
//  BookStep3TableViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 09/05/2022.
//

import UIKit

class BookStep3TableViewCell: UITableViewCell {

    @IBOutlet weak private var imgAvatar: UIImageView!
    @IBOutlet weak private var lblDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func config(service: String) {
        lblDetail.text = service
    }
}
