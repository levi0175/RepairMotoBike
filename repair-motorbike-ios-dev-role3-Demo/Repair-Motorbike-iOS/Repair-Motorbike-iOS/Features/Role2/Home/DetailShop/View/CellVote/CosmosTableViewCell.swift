//
//  CosmosTableViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 23/05/2022.
//

import UIKit
import Cosmos
protocol passDataComment: AnyObject {
    func passData(data: HomeGarageViewEntity.ListGarage1, numberVote: String, numberComment: Int)
}
class CosmosTableViewCell: UITableViewCell {
    @IBOutlet private weak var numberComment: UILabel!
    @IBOutlet private weak var numberVote: UILabel!
    @IBOutlet private weak var numberFive: UILabel!
    @IBOutlet private weak var contenView: UIView!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var btnVote: UIButton!
    private var listData: [DetailShopViewEntity.ListComment] = []
    private var dataGarage: HomeGarageViewEntity.ListGarage1?
    private var avegare = 0.0
    private var numberVotee = "0.0"
    private var numberCommentt = 0
    weak var delegate: passDataComment?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }
    func setUI() {
        cosmosView.settings.fillMode = .full
        cosmosView.settings.updateOnTouch = false
        numberComment.setSizeFont1(sizeFont: 25, font1: Font.FontName.RobotoRegular.rawValue)
        numberVote.setSizeFont1(sizeFont: 25, font1: Font.FontName.RobotoRegular.rawValue)
        contenView.addBorder(side: .bottom, color: .lightGray, width: 0.5)
        numberFive.setSizeFont1(sizeFont: 25, font1: Font.FontName.RobotoRegular.rawValue)
        btnVote.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width / 20)
        btnVote.setWidthButton()
    }
    @IBAction func voteButton(_ sender: Any) {
        if let dataGarage = dataGarage {
            delegate?.passData(data: dataGarage, numberVote: numberVotee, numberComment: numberCommentt)
        }
    }
    func getDataGara(data: HomeGarageViewEntity.ListGarage1) {
        dataGarage = data
    }
    func config(data: [DetailShopViewEntity.ListComment]) {
        avegare = 0.0
        listData = data
        for i in 0..<listData.count {
            avegare += Double(listData[i].numberStar)
        }
        if listData.isEmpty {
            numberVotee = "0.0"
            numberCommentt = 0
            numberVote.text = numberVotee
            numberComment.text = "\(numberCommentt) bình luận"
        } else {
            numberVotee = String(format: "%.1f", Double(avegare / Double(listData.count)))
            numberVote.text = "\(numberVotee)"
            numberCommentt = listData.count
            numberComment.text = "\(numberCommentt) bình luận"
            cosmosView.rating = Double(numberVotee) ?? 5.0
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
extension UIView {
    var parentCell: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
