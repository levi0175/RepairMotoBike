//
//  ChartCLVCell.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 17/05/2022.
//

import UIKit

class ChartCLVCell: UICollectionViewCell {

    let viewCell: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.View.T1
        return view
    }()
    let viewDate: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    let viewTop: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let lblDate: UILabel = {
        let label = UILabel()
        label.text = "17"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue", size: CGFloat(14))
        return label
    }()
    let lblDon: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue", size: CGFloat(14))
        return label
    }()
    var viewCellHeight: NSLayoutConstraint?
    var viewDateHeight: NSLayoutConstraint?
    var viewTopHeight: NSLayoutConstraint?
    private let dateFormatterPrint = DateFormatter()
    private let dateFormatter = DateFormatter()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateFormatter.dateFormat = "yyyy-dd-MM"
        dateFormatterPrint.dateFormat = "dd"
        setupView()
    }
    
    func setupView() {
        addSubviews(viewDate)
        addSubviews(viewCell)
        viewCell.addSubviews(lblDate)
        addSubview(viewTop)
        viewTop.addSubviews(lblDon)
        
        viewTopHeight = viewTop.heightAnchor.constraint(equalToConstant: 30)
        viewTopHeight?.isActive = true
        viewTop.bottomAnchor.constraint(equalTo: viewCell.topAnchor).isActive = true
        viewTop.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        viewTop.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        lblDate.centerXAnchor.constraint(equalTo: viewDate.centerXAnchor).isActive = true
        lblDate.centerYAnchor.constraint(equalTo: viewDate.centerYAnchor).isActive = true
        
        viewDateHeight = viewDate.heightAnchor.constraint(equalToConstant: 30)
        viewDateHeight?.isActive = true
        viewDate.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        viewDate.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        viewDate.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        viewCellHeight = viewCell.heightAnchor.constraint(equalToConstant: 100)
        viewCellHeight?.isActive = true
        viewCell.bottomAnchor.constraint(equalTo: viewDate.topAnchor).isActive = true
        viewCell.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        viewCell.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        lblDon.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor).isActive = true
        lblDon.centerXAnchor.constraint(equalTo: viewTop.centerXAnchor).isActive = true
    }
    func getData(data: StatisticalViewEntity.Chart) {
        lblDon.text = String(data.totalCustomer)
        if let date = dateFormatter.date(from: data.timeRepair) {
            lblDate.text = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
       // lblDate.text = data.timeRepair
    }
}
