//
//  UISearchView.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 09/05/2022.
//

import UIKit
final class UISearchView: UIView {
    // MARK: - IBOutlet
    @IBOutlet private weak var textFieldView: UIView!
    @IBOutlet private var containView: UIView!
    @IBOutlet private var textFieldLabel: UILabel!
    private override init(frame: CGRect) {
       super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
     super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        addSubViewAutoresizing(loadViewFromNib())
        setupView()
    }
    
    func setupView() {
        textFieldLabel.setSizeFont(sizeFont: 27)
        textFieldView.layer.cornerRadius = 5
        textFieldView.setBorder(color: AppColor.View.Red, width: 0.6)
      //  textFieldView.dropShadowWithCornerRaduis(corlor: .red)
    }
}

// MARK: - Public Handle Action
extension UISearchView {
    func getSearchView(at view: UIView) {
        view.addSubViewAutoresizing(self)
    }
}
