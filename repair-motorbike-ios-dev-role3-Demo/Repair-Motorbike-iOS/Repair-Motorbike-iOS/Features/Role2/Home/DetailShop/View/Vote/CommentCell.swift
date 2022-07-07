//
//  CommentCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 09/05/2022.
//

import UIKit
import Cosmos
class CommentCell: UICollectionViewCell {

    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var numberVote: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cosmosView.settings.fillMode = .full
        cosmosView.settings.updateOnTouch = false
    }
    func config(data: String) {
        numberVote.text = data
    }

}
