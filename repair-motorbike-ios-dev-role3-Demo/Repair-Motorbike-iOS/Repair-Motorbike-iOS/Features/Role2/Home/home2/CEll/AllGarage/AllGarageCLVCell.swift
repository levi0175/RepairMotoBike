//
//  AllGarageCLVCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 21/05/2022.
//

import UIKit
protocol passDataDetailVC: AnyObject {
    func passData(data: HomeGarageViewEntity.ListGarage1, dataComment: [HomeGarageViewEntity.CommentsHung], dataService: [HomeGarageViewEntity.ServiceListGaraHung])
}
class AllGarageCLVCell: UITableViewCell {
    @IBOutlet private weak var listShopCollectionView: UICollectionView!
    @IBOutlet private weak var heightContraint: NSLayoutConstraint!
    private var dataGarage: HomeGarageViewEntity = HomeGarageViewEntity()
    public var hanldeData: ((_ data: HomeGarageViewEntity.ListGarage1) -> Void)?

    weak var delegate: passDataDetailVC?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        listShopCollectionView.delegate = self
        listShopCollectionView.dataSource = self
        listShopCollectionView.registerCellNib1(type: DetailShopCell.self)
    }
    func config(dataGarage: HomeGarageViewEntity) {
        self.dataGarage = dataGarage
        print("________\(dataGarage)")
        self.listShopCollectionView.reloadData()
    }
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
           let height = self.listShopCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.heightContraint.constant = height
            self.listShopCollectionView.layoutIfNeeded()
            self.layoutIfNeeded()
            let contentSize = self.listShopCollectionView.collectionViewLayout.collectionViewContentSize
            return CGSize(width: contentSize.width, height: contentSize.height + 8)
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    private func setupCollectionView() {
    }
}
// MARK: - Setup CollectionView
extension AllGarageCLVCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataGarage.listGara.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellNib(type: DetailShopCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.clipsToBounds = true
        cell.config1(dataShop: dataGarage.listGara[indexPath.row], comment: dataGarage.listGara[indexPath.row].comments, service: dataGarage.listGara[indexPath.row].serviceList)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.passData(data: dataGarage.listGara[indexPath.row], dataComment: dataGarage.listGara[indexPath.row].comments, dataService: dataGarage.listGara[indexPath.row].serviceList)
//        if let parent = self.parentCell as? HomeGarageViewController {
//            let detailView = UIStoryboard(name: NameConstant.Storyboard.Detail, bundle: nil).instantiateVC(DetailShopViewController.self)
//            detailView.set(model: DetailShopModel())
//            detailView.listData = dataGarage.listGara[indexPath.row]
//            parent.navigationController?.pushViewController(detailView, animated: true)
//        }
    }
    
}

extension AllGarageCLVCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.06, height: collectionView.frame.width / 1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        UIScreen.main.bounds.width / 45
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}
// class DynamicCollectionView: UICollectionView {
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if bounds.size != intrinsicContentSize {
//            invalidateIntrinsicContentSize()
//        }
//    }
//
//    override var intrinsicContentSize: CGSize {
//         self.contentSize
// }
// }
