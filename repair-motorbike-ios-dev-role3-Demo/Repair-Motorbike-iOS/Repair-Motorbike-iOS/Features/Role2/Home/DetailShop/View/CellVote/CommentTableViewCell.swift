//
//  CommentTableViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 23/05/2022.
//

import UIKit
import Cosmos
class CommentTableViewCell: UITableViewCell {
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var numberVote: UILabel!
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    private let dateFormatter = DateFormatter()
    private let dateFormatterPrint = DateFormatter()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatterPrint.dateFormat = "yyyy-dd-MM HH:mm"
        cosmosView.settings.fillMode = .full
        cosmosView.settings.updateOnTouch = false
        nameLabel.setSizeFont1(sizeFont: 25, font1: Font.FontName.RobotoMedium.rawValue)
        numberVote.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        dateLabel.setSizeFont1(sizeFont: 35, font1: Font.FontName.RobotoRegular.rawValue)
        commentLabel.setSizeFont1(sizeFont: 28, font1: Font.FontName.RobotoRegular.rawValue)
        containView.addBorder(side: .bottom, color: .lightGray.withAlphaComponent(0.5), width: 0.5)
    }
    func config(data: DetailShopViewEntity.ListComment) {
        numberVote.text = "\(data.numberStar)"
        commentLabel.text = data.content
        nameLabel.text = "\(data.userName)"
        if let date = dateFormatter.date(from: data.createdTime ) {
            dateLabel.text = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        cosmosView.rating = Double(data.numberStar)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
