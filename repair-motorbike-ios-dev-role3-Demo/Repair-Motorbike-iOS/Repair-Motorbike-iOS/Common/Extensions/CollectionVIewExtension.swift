//
//  CollectionVIewExtension.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 05/05/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    /**
     Function Register Cell Nib.
     - Parameters:
        - cell: class cell Nib.
    */
    func registerCellNib1<T: UICollectionViewCell>(type cell: T.Type) {
        let nib = UINib(nibName: "\(cell.self)", bundle: nil)
        register(nib, forCellWithReuseIdentifier: "\(cell.self)")
    }
    
    /**
     Function dequeue Reusable Cell Nib.
     - Parameters:
        - cell: class cell Nib.
        - indexPath: Vị trí cell.
    */
    func dequeueReusableCellNib<T: UICollectionViewCell>(type cell: T.Type, for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(cell.self)", for: indexPath) as? T else {
            Logger.error("Could not dequeue cell with identifier: \(cell.self)")
            return nil
        }
        return cell
    }
}
