//
//  ServiceCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 02/05/2022.
//

import UIKit

class ServiceCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var serviceCLVCell: UICollectionView!
    // MARK: - Variables
    var nextButton = 0
    private var dataStoreService: DetailShopViewEntity?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
}
// MARK: - Setup UI
extension ServiceCell {
    func setUI() {
        serviceCLVCell.delegate = self
        serviceCLVCell.dataSource = self
        serviceCLVCell.registerCellNib1(type: ServiceChildCell.self)
        serviceCLVCell.registerCellNib1(type: VoteCell.self)
        serviceCLVCell.registerCellNib1(type: CommentCell.self)
        
    }
}
// MARK: - Setup CollectionView
extension ServiceCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataStoreService?.listAllStoreService.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellNib(type: ServiceChildCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        if let dataStoreService = dataStoreService {
            cell.configService(data: dataStoreService.listAllStoreService[indexPath.row])
        }
        return cell
        
    }
    func configDetail(data: DetailShopViewEntity) {
        dataStoreService = data
        self.serviceCLVCell.reloadData()
    }
}

extension ServiceCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeSlider = serviceCLVCell.frame.size
        return CGSize(width: sizeSlider.width, height: sizeSlider.width / 8 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}
