//  
//  CalenderViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 27/04/2022.
//

import UIKit

final class CalenderViewController: BaseViewController {
    // MARK: - IBOutlet
    
    // MARK: - Variables
    private var model: CalenderContract.Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

// MARK: - Setup UI
extension CalenderViewController {
    private func setupUI() {
    }
}

// MARK: - Handle Action
extension CalenderViewController {
}

extension CalenderViewController: CalenderControllerProtocol {
    func set(model: CalenderContract.Model) {
        self.model = model
    }
}
