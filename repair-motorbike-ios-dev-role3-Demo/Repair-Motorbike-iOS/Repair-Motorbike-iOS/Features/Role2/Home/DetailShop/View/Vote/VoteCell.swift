//
//  VoteCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 09/05/2022.
//

import UIKit
import Cosmos
class VoteCell: UICollectionViewCell {

    @IBOutlet private weak var numberComment: UILabel!
    @IBOutlet private weak var numberVote: UILabel!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var btnVote: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        cosmosView.settings.fillMode = .full
        cosmosView.settings.updateOnTouch = false
        btnVote.setWidthButton()
    }
    @IBAction func voteButton(_ sender: Any) {
        if let parent = self.parentCell as? DetailShopViewController {
            let detailView = UIStoryboard(name: NameConstant.Storyboard.Evaluate, bundle: nil).instantiateVC(EvaluateViewController.self)
           // detailView.data = data
           // detailView.set(model: SearchModel())
            parent.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    func config(data: String) {
        numberVote.text = data
    }
}
