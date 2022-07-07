//  
//  EvaluateViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 10/05/2022.
//

import UIKit
import Cosmos
protocol loadCommentProtocol: AnyObject {
    func loadData()
}
final class EvaluateViewController: BaseViewController {
    // MARK: - IBOutlet
    
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    @IBOutlet private weak var textFliedComment: UITextField!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var numberPhone: UILabel!
    @IBOutlet private weak var contactLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var buttonSend: UIButton!
    
    // MARK: - Variables
    private var model: EvaluateContract.Model?
    private var data: EvaluateViewEntity?
    var dataGara: HomeGarageViewEntity.ListGarage1?
    private var ratingStar: Double?
    weak var delegate: loadCommentProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        cosmosView.didFinishTouchingCosmos = didFinishTouchingCosmos
        setupUI()
    }
}

// MARK: - Setup UI
extension EvaluateViewController {
    private func setupUI() {
        setupCosmos()
        setupNavi()
        setupLabel()
        self.tappedHideKeyboard()
        tabBarController?.tabBar.isHidden = true
    }
    func setupCosmos() {
        cosmosView.settings.starSize = UIScreen.main.bounds.width / 8
        cosmosView.settings.fillMode = .full
    }
    private func setupNavi() {
        naviBar.configData(title: NameConstant.Storyboard.Evaldule)
        naviBar.tappedBack {
            self.navigationController?.popViewController(animated: true)
        }
        naviBar.hiddenSave()
    }
    private func setupLabel() {
        addressLabel.text = dataGara?.address
        nameLabel.text = dataGara?.name
        numberPhone.text = dataGara?.phone
        addressLabel.setSizeFont1(sizeFont: 35, font1: Font.FontName.RobotoRegular.rawValue)
        nameLabel.setSizeFont1(sizeFont: 17, font1: Font.FontName.RobotoMedium.rawValue)
        numberPhone.setSizeFont1(sizeFont: 35, font1: Font.FontName.RobotoRegular.rawValue)
        textFliedComment.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width / 25)
        contactLabel.setSizeFont1(sizeFont: 35, font1: Font.FontName.RobotoRegular.rawValue)
        buttonSend.dropShadowWithCornerRaduis(corlor: UIColor.purple)
        buttonSend.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
    }
}

// MARK: - Handle Action
extension EvaluateViewController {
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    private func didFinishTouchingCosmos(_ rating: Double) {
        ratingStar = rating
    }
    @IBAction func handleComent(_ sender: Any) {
        cosmosView.didFinishTouchingCosmos = { rating in
            print("______\(rating)")
            self.ratingStar = rating
        }
        let userId = UserDefaults.standard.integer(forKey: NameConstant.UserDefaults.userID)
        model?.postComment(idUser: userId, idStore: dataGara?.storeId ?? 1, star: Int(ratingStar ?? 0), content: textFliedComment.text ?? "", createdTime: "\(Date().timeIntervalSinceReferenceDate)") { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                DispatchQueue.main.async {
                    self?.showAlert(message: "Đã gửi bình luận.")
                    self?.navigationController?.popViewController(animated: true)
                }
                self?.delegate?.loadData()
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
        
    }
}

extension EvaluateViewController: EvaluateControllerProtocol {
    func set(model: EvaluateContract.Model) {
        self.model = model
    }
}
