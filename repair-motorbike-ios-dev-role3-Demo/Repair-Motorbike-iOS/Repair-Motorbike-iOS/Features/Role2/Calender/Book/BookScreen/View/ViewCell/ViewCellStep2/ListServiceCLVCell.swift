//
//  ListServiceCLVCell.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 05/05/2022.
//

import UIKit

protocol DelegateListStep2Cell: AnyObject {
    func DidSelectCheckAdd(check: Bool)
    
}

class ListServiceCLVCell: UICollectionViewCell {

    @IBOutlet private weak var imgCheck: UIImageView!
    @IBOutlet private weak var lblList: UILabel!
  
    var check1: Bool = false
    weak var delegate: DelegateListStep2Cell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCheck.isHidden = true
       
    }
    func configCheck(check: Bool) {
            if check == true {
            imgCheck.isHidden = false
            } else {
                imgCheck.isHidden = true
            }
        }

    func config(text: HomeGarageViewEntity.ServiceListGaraHung) {
        lblList.text = text.name
    }
}
