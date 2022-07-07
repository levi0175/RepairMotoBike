//
//  Step2CollectionViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 21/05/2022.
//

import UIKit

protocol DelegateStep2: AnyObject {
    func DelegateStep2(list: [HomeGarageViewEntity.ServiceListGaraHung], check: Bool )
    
}

class Step2CollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var txtSearch: UITextField!
    @IBOutlet private weak var viewSearch: UIView!
    @IBOutlet private weak var listServicecollectionView: UICollectionView!
    @IBOutlet private weak var imgCheckXeSo: UIImageView!
    @IBOutlet private weak var imgCheckXeGa: UIImageView!
    @IBOutlet private weak var imgCheckXeCon: UIImageView!
    
    let value: [String] = [ "Dịch vụ bảo dưỡng oto", "chuyên nhân sửa chữa oto tại nhà", "Dịch vụ bảo dưỡng oto", "dịch vụ sửa chữa oto"]
    var listData: [HomeGarageViewEntity.ServiceListGaraHung] = []
    var listData1: [HomeGarageViewEntity.ServiceListGaraHung] = []
    var listChose: [Int] = []
    var checkList: Bool = false
    var checkNextScreen: Bool = false
    weak var delegate: DelegateStep2?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTableView()
        setDefaultChoseXe()
        setupUI()
    }

}
extension Step2CollectionViewCell {
    private func setupUI() {
        viewSearch.setBorder(color: .red, width: 1)
        viewSearch.layer.cornerRadius = 10
    }
    private func setupTableView() {
        listServicecollectionView.backgroundColor = .clear
        listServicecollectionView.dataSource = self
        listServicecollectionView.delegate = self
        listServicecollectionView.registerCellNib1(type: ListServiceCLVCell.self)

    }
    func setDefaultChoseXe() {
        imgCheckXeGa.image = UIImage(named: AppImage.Icon.unclick)
        imgCheckXeSo.image = UIImage(named: AppImage.Icon.unclick)
        imgCheckXeCon.image = UIImage(named: AppImage.Icon.unclick)
    }
    func configCha(ListFromSearch: [HomeGarageViewEntity.ServiceListGaraHung], check: Bool) {
        listData = ListFromSearch
        listChose.removeAll()
        for _ in 0..<listData.count {
            listChose.append(0)
        }
        listServicecollectionView.reloadData()
        
    }
   
}

// MARK: - Handle Action
extension Step2CollectionViewCell {
    @IBAction func btnChoseType(_ sender: Any) {
        switch (sender as AnyObject).tag {
        case 0:
                imgCheckXeGa.image = UIImage(named: AppImage.Icon.unclick)
                imgCheckXeSo.image = UIImage(named: AppImage.Icon.click)
                imgCheckXeCon.image = UIImage(named: AppImage.Icon.unclick)
        case 1:
                imgCheckXeGa.image = UIImage(named: AppImage.Icon.click)
                imgCheckXeSo.image = UIImage(named: AppImage.Icon.unclick)
                imgCheckXeCon.image = UIImage(named: AppImage.Icon.unclick)
        case 2:
                imgCheckXeGa.image = UIImage(named: AppImage.Icon.unclick)
                imgCheckXeSo.image = UIImage(named: AppImage.Icon.unclick)
                imgCheckXeCon.image = UIImage(named: AppImage.Icon.click)
        default:
                break
        }
    }
    
}

extension Step2CollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellNib(type: ListServiceCLVCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 7
               cell.layer.borderWidth = 0.0
               cell.layer.shadowColor = UIColor.black.cgColor
               cell.layer.shadowOffset = CGSize(width: 3, height: 5)
               cell.layer.shadowRadius = 3
               cell.layer.shadowOpacity = 5
               cell.layer.masksToBounds = false
        cell.config(text: listData[indexPath.row])
        cell.configCheck(check: listData[indexPath.row].check)
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  aaa = indexPath.row
//               if aaa == indexPath.row {
//                   if listChose[aaa] == 0 {
//                     //  listData1.append(listData[aaa])
//                       listData1.append(listData[aaa])
//                       print("a1 \(listData1)")
//                       listChose[aaa] = 1
//                   } else if listChose[aaa] == 1 {
//                       listData1.remove(at: aaa)
//                       listChose[aaa] = 0
//                   }
//                   delegate?.DelegateStep2(list: listData1)
//               } else {
//                   print("2")
//               }
       
        listData[indexPath.row].check = !listData[indexPath.row].check
        listChose.append(indexPath.row)
        
        var arrI = [Int]()
        for (i, e) in self.listData.enumerated() {
            print("e: \(e)")
            print("e1: \(!e.check)")
            if !e.check {
                arrI.append(i)
               
            }
        }
       
        if arrI.count > -1 {
            let arrayR = self.listData
                .enumerated()
                .filter { !arrI.contains($0.offset) }
                .map { $0.element }
            self.listData1 = arrayR
            checkNextScreen = true
            
        }
        delegate?.DelegateStep2(list: listData1, check: checkNextScreen)
             print("ListChose______", listChose)
               listServicecollectionView.reloadData()

}
}

extension Step2CollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         CGSize(width: collectionView.frame.size.width - 10, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
extension Step2CollectionViewCell: DelegateListStep2Cell {
    func DidSelectCheckAdd(check: Bool) {
        checkList = check
    }
        
}
