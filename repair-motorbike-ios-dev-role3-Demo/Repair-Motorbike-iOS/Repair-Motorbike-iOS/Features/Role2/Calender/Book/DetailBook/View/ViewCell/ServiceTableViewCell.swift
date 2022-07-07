//
//  ServiceTableViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 26/05/2022.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var leftView: UIView!
    @IBOutlet private weak var lbCount: UILabel!
    @IBOutlet private weak var lbList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(count: String, list: String) {
        lbCount.text = count
        lbList.text = list
    }
}
