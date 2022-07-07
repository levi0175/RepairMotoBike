//
//  InfomationCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 02/05/2022.
//

import UIKit

class InfomationCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func getData(data: HomeGarageViewEntity.ListGarage1) {
        textView.text = "Thong tin shop"
    }
}
