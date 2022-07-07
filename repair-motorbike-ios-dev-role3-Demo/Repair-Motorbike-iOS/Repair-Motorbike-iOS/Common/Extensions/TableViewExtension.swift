//
//  TableViewExtension.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit

extension UITableView {
    /**
     Function Register Cell Nib.
     - Parameters:
        - cell: class cell Nib.
    */
    func registerCellNib<T: UITableViewCell>(type cell: T.Type) {
        let nib = UINib(nibName: "\(cell.self)", bundle: nil)
        register(nib, forCellReuseIdentifier: "\(cell.self)")
    }
    
    /**
     Function dequeue Reusable Cell Nib.
     - Parameters:
        - cell: class cell Nib.
        - indexPath: Vị trí cell.
    */
    func dequeueReusableCellNib<T: UITableViewCell>(type cell: T.Type, for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: "\(cell.self)", for: indexPath) as? T else {
            Logger.error("Could not dequeue cell with identifier: \(cell.self)")
            return nil
        }
        return cell
    }
    func indicatorView() -> UIActivityIndicatorView {
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 80)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            
            if #available(iOS 13.0, *) {
                activityIndicatorView.style = .medium
            } else {
                // Fallback on earlier versions
                activityIndicatorView.style = .white
            }
            
            activityIndicatorView.color = .systemGray
            activityIndicatorView.hidesWhenStopped = true

            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        } else {
            return activityIndicatorView
        }
    }

    func addLoading(_ indexPath: IndexPath, closure: @escaping (() -> Void)) {
        indicatorView().startAnimating()
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
        }
    }

    func stopLoading() {
        if self.tableFooterView != nil {
            self.indicatorView().stopAnimating()
            self.tableFooterView = nil
        } else {
            self.tableFooterView = nil
        }
    }
}
