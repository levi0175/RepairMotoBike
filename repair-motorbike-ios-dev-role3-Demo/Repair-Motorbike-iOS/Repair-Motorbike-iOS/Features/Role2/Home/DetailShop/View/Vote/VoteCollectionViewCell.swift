//
//  VoteCollectionViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 10/05/2022.
//

import UIKit
protocol getDataCommentFromDetailProtocol: AnyObject {
    func getData(data: HomeGarageViewEntity.ListGarage1, numberVote: String, numberComment: Int)
}
class VoteCollectionViewCell: UICollectionViewCell {
 
    // MARK: - IBOutlet
    @IBOutlet private weak var tableViewVote: UITableView!
    // MARK: - Variables
    var nextButton = 0
    private var dataGetListComment: DetailShopViewEntity?
    private var dataGarage: HomeGarageViewEntity.ListGarage1?
    weak var delegate: getDataCommentFromDetailProtocol?
    lazy var myRefreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableViewVote.refreshControl = myRefreshControl
        setUI()
    }
    
    @objc
    func refresh(sender: UIRefreshControl) {
        tableViewVote.reloadData()
        sender.endRefreshing()
    }
}
// MARK: - Setup UI
extension VoteCollectionViewCell {
    func setUI() {
        tableViewVote.delegate = self
        tableViewVote.dataSource = self
        tableViewVote.registerCellNib(type: CosmosTableViewCell.self)
        tableViewVote.registerCellNib(type: CommentTableViewCell.self)
    }
}

// MARK: - Setup TabView
extension VoteCollectionViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return dataGetListComment?.listCommentList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCellNib(type: CosmosTableViewCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            if let dataGetListComment = dataGetListComment {
                cell.config(data: dataGetListComment.listCommentList)
            }
            if let data = dataGarage {
                cell.getDataGara(data: data)
                cell.delegate = self
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCellNib(type: CommentTableViewCell.self, for: indexPath) else {
                return UITableViewCell()
        }
        if var dataGetListComment = dataGetListComment {
            dataGetListComment.listCommentList.reverse()
            cell.config(data: dataGetListComment.listCommentList[indexPath.row])
        }
        return cell
    }
    func getData(data: DetailShopViewEntity) {
        dataGetListComment = data
        tableViewVote.reloadData()
    }
    func getDataGara(data: HomeGarageViewEntity.ListGarage1) {
        dataGarage = data
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hung")
    }
    func scrollToLastRow() {
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.tableViewVote.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
}
extension VoteCollectionViewCell: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         UITableView.automaticDimension
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 90
//        }
//        return UITableView.automaticDimension
//    }
}
extension VoteCollectionViewCell: passDataComment {
    func passData(data: HomeGarageViewEntity.ListGarage1, numberVote: String, numberComment: Int) {
        if let data = dataGarage {
            delegate?.getData(data: data, numberVote: numberVote, numberComment: numberComment)
        }
    }

}
// extension VoteCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        2
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        }
//        return 10
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0 {
//            guard let cell = collectionView.dequeueReusableCellNib(type: VoteCell.self, for: indexPath) else {
//                return UICollectionViewCell()
//            }
//            cell.config(data: "\(indexPath.row)")
//            return cell
//        }
//        guard let cell = collectionView.dequeueReusableCellNib(type: CommentCell.self, for: indexPath) else {
//            return UICollectionViewCell()
//        }
//        cell.config(data: "\(indexPath.row)")
//        return cell
//
//    }
// }
//
// extension VoteCollectionViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let sizeSlider = commentCell.frame.size
//        if indexPath.section == 0 {
//            return CGSize(width: sizeSlider.width, height: 90)
//        }
//        return CGSize(width: sizeSlider.width, height: 120)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        0.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        0.0
//    }
// }
