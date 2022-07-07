//  
//  StatisticalViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import UIKit

final class StatisticalViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var chartCollectionView: UICollectionView!
    @IBOutlet private weak var viewAllOder: UIView!
    @IBOutlet private weak var viewAllPrice: UIView!
    @IBOutlet private weak var lblTongDon: UILabel!
    @IBOutlet  private weak var lblGia: UILabel!
    
    // MARK: - Variables
    private var model: StatisticalContract.Model?
    public var listData: StatisticalViewEntity.Chart?
    private var dataChartService: StatisticalViewEntity?
    
    var select: Int = -1
    var valuesArr: [CGFloat] = []
    let values: [CGFloat] = [2, 66, 77, 66, 2, 3, 4, 6, 10, 50, 100, 66, 77, 66, 4, 5, 66, 77, 66, 6, 10, 50, 90, 1]
    let string1: [String] = ["3", "4", "4", "5", "2", "3", "4", "6", "10", "50", "100", "1", "2", "3", "4", "5", "2", "'3'", "4", "6", "10", "50", "90", "1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.View.Red ?? UIColor.red]
        navigationController?.navigationBar.barTintColor = AppColor.View.White
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = AppColor.View.Red
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Thống kê cửa hàng"
        setupUI()
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model?.getListChartDay(storeId: 1) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataChartService = data
                if let dataChartService = self?.dataChartService {
                    for i in dataChartService.listChart {
                        self?.valuesArr.append(CGFloat(i.totalCustomer))
                    }
                }
                DispatchQueue.main.async {
                    self?.chartCollectionView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
}

// MARK: - Setup UI
extension StatisticalViewController {
    private func setupUI() {
        viewAllPrice.layer.cornerRadius = 20
        viewAllOder.layer.cornerRadius = 20
    }
    private func  setupCollectionView() {
        chartCollectionView.registerCellNib1(type: ChartCLVCell.self)
        chartCollectionView.delegate = self
        chartCollectionView.dataSource = self
        chartCollectionView.isPagingEnabled = true
        if let flowLayout = chartCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
    }
}

// MARK: - Handle Action
extension StatisticalViewController {
}

extension StatisticalViewController: StatisticalControllerProtocol {
    func set(model: StatisticalContract.Model) {
        self.model = model
    }
    func maxHeight() -> CGFloat {
        chartCollectionView.frame.height - 44 - 8 - 20
    }
}

extension StatisticalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataChartService?.listChart.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellNib(type: ChartCLVCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        if select == indexPath.row {
            let chan = select / 2
            cell.viewCell.alpha = 1
            if select % 2 == 0 {
                if chan % 2 == 0 {
                    cell.viewCell.backgroundColor = AppColor.View.c1
                } else {
                    cell.viewCell.backgroundColor = AppColor.View.c2
                }
            } else {
                if chan % 2 == 0 {
                    cell.viewCell.backgroundColor = AppColor.View.c3
                } else {
                    cell.viewCell.backgroundColor = AppColor.View.c4
                }
            }
        } else {
           
            let chan = indexPath.row / 2
            cell.viewCell.alpha = 0.5
            if indexPath.row % 2 == 0 {
                if chan % 2 == 0 {
                    cell.viewCell.backgroundColor = AppColor.View.c1
                } else {
                    cell.viewCell.backgroundColor = AppColor.View.c2
                }
            } else {
                if chan % 2 == 0 {
                    cell.viewCell.backgroundColor = AppColor.View.c3
                } else {
                    cell.viewCell.backgroundColor = AppColor.View.c4
                }
            }
        }
        if let dataChartService = dataChartService {
            cell.getData(data: dataChartService.listChart[indexPath.row])
        }
       if let max = valuesArr.max() {
            let value = valuesArr[indexPath.row]
           let ratio = value / (max * 1.5)
        
           cell.viewCellHeight?.constant = maxHeight() * CGFloat(ratio)
           cell.viewDateHeight?.constant = 40
       }
        
        return cell
    }
    
}
extension StatisticalViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        select = indexPath.row
        if let dataChartService = dataChartService {
            lblTongDon.text = String(dataChartService.listChart[indexPath.row].totalCustomer)
            lblGia.text = String(dataChartService.listChart[indexPath.row].totalPrice)
        }
        print(string1[indexPath.row])
        chartCollectionView.reloadData()
    }
}
extension StatisticalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 25, height: maxHeight())
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
}
