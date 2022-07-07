//
//  ServiceChildCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 02/05/2022.
//

import UIKit

class ServiceChildCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var nameServiceLbl: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var containView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configService(data: DetailShopViewEntity.ListShop) {
        containView.layer.cornerRadius = 5
        nameServiceLbl.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width / 30)
        price.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width / 30)
        nameServiceLbl.text = data.name
        price.text = "Giá: \(data.price) Đ"
    }
}
