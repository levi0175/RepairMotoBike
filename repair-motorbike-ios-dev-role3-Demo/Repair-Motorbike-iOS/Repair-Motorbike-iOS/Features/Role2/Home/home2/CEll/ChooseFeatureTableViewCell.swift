//
//  ChooseFeatureTableViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 21/05/2022.
//

import UIKit
protocol FirstChildVCDelegate: AnyObject {
    func didAction(data: String)
    func changeScreenProvinece(data: String)
}
class ChooseFeatureTableViewCell: UITableViewCell {
    @IBOutlet private weak var btnSearchBar: UIButton!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var bookView: UIView!
    @IBOutlet private weak var cleanView: UIView!
    @IBOutlet private weak var giftView: UIView!
    @IBOutlet private weak var dropDownCountry: UIView!
    @IBOutlet private weak var btnDropDown: UIButtonBorder!
    
    weak var delegate: FirstChildVCDelegate?
    var data: HomeGarageViewEntity.ListGarage1?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnSearchBar.addTarget(self, action: #selector(actionWithParam), for: .touchUpInside)
        setupView()
       
    }
    func getProvince(data: String) {
        btnDropDown.textLbl = data
    }
    @objc
    func actionWithParam(sender: UIButton) {
        delegate?.didAction(data: "HUngDeptrai")
    }
    @IBAction func chooseProvince(_ sender: Any) {
        delegate?.changeScreenProvinece(data: "ha no")
    }
    @IBAction func chooseClean(_ sender: Any) {
        if let parent = self.parentCell as? HomeGarageViewController {
            let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(NotthingViewController.self)
            parent.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    @IBAction func chooseGift(_ sender: Any) {
        if let parent = self.parentCell as? HomeGarageViewController {
            let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(NotthingViewController.self)
            parent.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    @IBAction func searchGarage(_ sender: Any) {
        if let parent = self.parentCell as? HomeGarageViewController {
          
            let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(SearchViewController.self)
            detailView.set(model: SearchModel())
            parent.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    @IBAction func btnnext(_ sender: Any) {
        if let parent = self.parentCell as? HomeGarageViewController {
            let detailView = UIStoryboard(name: NameConstant.Storyboard.Book, bundle: nil).instantiateVC(BookViewController.self)
            detailView.navigationController?.navigationBar.isHidden = false
            detailView.set(model: BookModel())
            parent.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setupView () {
        setupSearchView()
        setupBookView()
        setupCleanView()
        setupGiftView()
    }
    private func setupSearchView() {
        let search = UISearchView()
        search.getSearchView(at: searchView)
    }
    private func setupBookView() {
        let book = UIButtonHomeView()
        book.textLabel = NameConstant.ViewHome.schedule
        book.imageView = UIImage(named: AppImage.Image.Booking)
        book.getButtomHome(at: bookView)
    }
    private func setupCleanView() {
        let clean = UIButtonHomeView()
        clean.textLabel = NameConstant.ViewHome.clean
        clean.imageView = UIImage(named: AppImage.Image.Clean)
        clean.getButtomHome(at: cleanView)
    }
    private func setupGiftView() {
        let gift = UIButtonHomeView()
        gift.imageView = UIImage(named: AppImage.Image.Gift)
        gift.textLabel = NameConstant.ViewHome.gift
        gift.getButtomHome(at: giftView)
    }
}
