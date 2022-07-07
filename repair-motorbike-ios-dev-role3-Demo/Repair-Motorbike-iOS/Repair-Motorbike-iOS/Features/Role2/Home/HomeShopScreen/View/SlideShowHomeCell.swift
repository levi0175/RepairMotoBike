//
//  SlideShowHomeCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 26/04/2022.
//

import UIKit

class SlideShowHomeCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.setBorder()
    }
    func config(data: UIImage) {
        imageView.image = data
    }
}
