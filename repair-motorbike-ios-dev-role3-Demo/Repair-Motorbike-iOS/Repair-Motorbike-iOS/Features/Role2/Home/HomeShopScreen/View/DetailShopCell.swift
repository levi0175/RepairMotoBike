//
//  DetailShopCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 27/04/2022.
//

import UIKit

class DetailShopCell: UICollectionViewCell {
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var numberVote: UILabel!
    @IBOutlet private weak var numberMess: UILabel!
    @IBOutlet private weak var numberCap: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var containView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setSizeLabel()
        setLayOut()
        
    }
    func setLayOut() {
        avatarImage.round(corners: [.topLeft, .topRight], radius: 10, borderColor: .clear, borderWidth: 0)
         avatarImage.layer.cornerRadius = 10
         containView.layer.cornerRadius = 20
         setBlurImage(imageBlur: avatarImage)
    }
    func config1(dataShop: HomeGarageViewEntity.ListGarage1, comment: [HomeGarageViewEntity.CommentsHung], service: [HomeGarageViewEntity.ServiceListGaraHung]) {
        nameLabel.text = dataShop.name
        addressLabel.text = dataShop.address
        print(comment)
        numberCap.text = "\(0)"
        numberMess.text = String(comment.count)
        numberVote.text = String(service.count)
    }
    private func setSizeLabel() {   
        nameLabel.setSizeFont1(sizeFont: 23, font1: Font.FontName.RobotoMedium.rawValue)
        addressLabel.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        numberVote.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        numberMess.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        numberCap.setSizeFont1(sizeFont: 33, font1: Font.FontName.RobotoRegular.rawValue)
        
    }
    private func setBlurImage(imageBlur: UIImageView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: imageBlur.frame.size.width, height: imageBlur.frame.size.height * 0.3))
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.7).cgColor, UIColor.clear.cgColor]
        imageBlur.layer.addSublayer(gradientLayer)

        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = CGRect(origin: CGPoint(x: 0, y: (imageBlur.frame.size.height - imageBlur.frame.size.height * 0.3)), size: CGSize(width: imageBlur.frame.size.width, height: imageBlur.frame.size.height * 0.3))
        gradientLayer2.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        imageBlur.layer.addSublayer(gradientLayer2)
    }

}
