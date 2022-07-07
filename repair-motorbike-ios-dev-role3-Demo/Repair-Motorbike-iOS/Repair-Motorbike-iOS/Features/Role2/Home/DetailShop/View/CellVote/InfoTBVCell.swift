//
//  InfoTBVCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 28/05/2022.
//

import UIKit

class InfoTBVCell: UITableViewCell {
    @IBOutlet private weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.font = UIFont(name: Font.FontName.RobotoRegular.rawValue, size: UIScreen.main.bounds.width / 25)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
