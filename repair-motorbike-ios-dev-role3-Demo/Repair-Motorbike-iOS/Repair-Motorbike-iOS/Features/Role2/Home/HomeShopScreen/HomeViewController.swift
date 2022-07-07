//  
//  HomeViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit
import SwiftUI

final class HomeViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var btnShowCountry: UIButton!
    @IBOutlet private weak var btnSearchBar: UIButton!
    @IBOutlet private weak var sliderCollectionView: UICollectionView!
    @IBOutlet private weak var dropDownCountry: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var listShopCollectionView: UICollectionView!
    @IBOutlet private weak var heightContentView: NSLayoutConstraint!

    @IBOutlet private var containMainView: UIView!
    @IBOutlet private weak var loadViewHomee: UIActivityIndicatorView!
    @IBOutlet private weak var bookView: UIView!
    @IBOutlet private weak var cleanView: UIView!
    @IBOutlet private weak var giftView: UIView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var pageView: UIPageControl!
    // MARK: - Variables
    private var timer = Timer()
    private var counter = 0
    private var model: HomeContract.Model?
    private var data: HomeViewEntity = HomeViewEntity()
    private var imgArrSlideShow = [UIImage(named: AppImage.Image.slide1), UIImage(named: AppImage.Image.slide2), UIImage(named: AppImage.Image.slide3), UIImage(named: AppImage.Image.slide4), UIImage(named: AppImage.Image.slide5)]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewHomee.startAnimating()
        loadViewHomee.hidesWhenStopped = true
        containMainView.layer.opacity = 0.5
        model?.getListShop { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                    print(data)
                DispatchQueue.main.async {
                    self?.listShopCollectionView.reloadData()
                    self?.loadViewHomee.stopAnimating()
                    self?.containMainView.layer.opacity = 1
                }
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setHeightScrollView()
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        handleSlideShow()

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    // next

}
// MARK: - Handle Action
extension HomeViewController {
    @IBAction func chooseProvince(_ sender: Any) {
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(ProvinceeViewController.self)
      //  detailView.data = data
        // detailView.set(model: SearchModel())
        navigationController?.pushViewController(detailView, animated: true)
    }
    @IBAction func chooseClean(_ sender: Any) {
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(NotthingViewController.self)
        navigationController?.pushViewController(detailView, animated: true)
    }
    @IBAction func chooseGift(_ sender: Any) {
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(NotthingViewController.self)
        navigationController?.pushViewController(detailView, animated: true)
    }
    @IBAction func searchGarage(_ sender: Any) {
     
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(SearchViewController.self)
        detailView.set(model: SearchModel())
        navigationController?.pushViewController(detailView, animated: true)
    }
    @IBAction func btnnext(_ sender: Any) {
        print("sss")
        let detailView = UIStoryboard(name: NameConstant.Storyboard.Book, bundle: nil).instantiateVC(BookViewController.self)
        detailView.navigationController?.navigationBar.isHidden = false

        detailView.set(model: BookModel())
     //   detailView.listData = data.listAllShop[<#Int#>]
        // detailView.set(model: SearchModel())

        navigationController?.pushViewController(detailView, animated: true)
    }
    private func handleSlideShow() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.handleImageSlideShow), userInfo: nil, repeats: true)
        }
        pageView.numberOfPages = imgArrSlideShow.count
        pageView.currentPage = 0
    }

    @objc
    func handleImageSlideShow() {
        if counter < imgArrSlideShow.count {
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
}
// MARK: - Setup UI
extension HomeViewController {
    private func setupUI() {
        tabBarController?.tabBar.isHidden = false
        setupCollectionView()
        setupBookView()
        setupGiftView()
        setupCleanView()
        setupSearchView()
        setupDropdownView()
    }
    private func setupCollectionView() {
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        listShopCollectionView.delegate = self
        listShopCollectionView.dataSource = self
        sliderCollectionView.registerCellNib1(type: SlideShowHomeCell.self)
        listShopCollectionView.registerCellNib1(type: DetailShopCell.self)
    }
    private func setHeightScrollView() {
        scrollView.layoutIfNeeded()
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: listShopCollectionView.frame.size.height + 600)
       // heightContentView.constant = CGFloat(215 * data.listAllShop.count)
    }
    private func setupDropdownView() {
        let dropdown = UIButtonBorder()
        dropdown.getButtonBorder(at: dropDownCountry)
        //        btnShowCountry.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width / 30)
    }
    private func setupSearchView() {
        let search = UISearchView()
        search.getSearchView(at: searchView)
    }
    private func setupBookView() {
        let book = UIButtonHomeView()
        book.textLabel = NameConstant.ViewHome.schedule
        book.imageView = UIImage(named: AppImage.Image.Booking)
//        book.imageVIew.image = UIImage(named: AppImage.Image.Booking)
//        book.titleLabel.text = NameConstant.ViewHome.schedule
        book.getButtomHome(at: bookView)
    }
    private func setupCleanView() {
        let clean = UIButtonHomeView()
        clean.textLabel = NameConstant.ViewHome.clean
        clean.imageView = UIImage(named: AppImage.Image.Clean)
//        clean.imageVIew.image = UIImage(named: AppImage.Image.Clean)
//        clean.titleLabel.text = NameConstant.ViewHome.clean
        clean.getButtomHome(at: cleanView)
    }
    private func setupGiftView() {
        let gift = UIButtonHomeView()
        gift.imageView = UIImage(named: AppImage.Image.Gift)
        gift.textLabel = NameConstant.ViewHome.gift
//        gift.imageVIew.image = UIImage(named: AppImage.Image.Gift)
//        gift.titleLabel.text = NameConstant.ViewHome.gift
        gift.getButtomHome(at: giftView)
    }

}
// MARK: - Setup CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == listShopCollectionView {
            if data.listAllShop.count > 20 {
                return 20
            }
            return data.listAllShop.count
        }
        return imgArrSlideShow.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == listShopCollectionView {
            guard let cell = collectionView.dequeueReusableCellNib(type: DetailShopCell.self, for: indexPath) else {
                return UICollectionViewCell()
            }
         //   cell.config(dataShop: data.listAllShop[indexPath.row])
            return cell
        }
        guard let cell = collectionView.dequeueReusableCellNib(type: SlideShowHomeCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }

        cell.config(data: imgArrSlideShow[indexPath.row]!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == listShopCollectionView {

            let detailView = UIStoryboard(name: NameConstant.Storyboard.Detail, bundle: nil).instantiateVC(DetailShopViewController.self)
            detailView.set(model: DetailShopModel())
//            detailView.listData = data.listAllShop[indexPath.row]
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        counter = indexPath.row
        pageView.currentPage = counter
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeSlider = sliderCollectionView.frame.size
        let sizeShop = listShopCollectionView.frame.size
        if collectionView == listShopCollectionView {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return CGSize(width: sizeShop.width / 4 - 2, height: 215)
            }
            return CGSize(width: sizeShop.width / 2 - 2, height: 215)
        }
        return CGSize(width: sizeSlider.width, height: sizeSlider.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == listShopCollectionView {
            return 5
        }
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}
extension HomeViewController: HomeControllerProtocol {
    func set(model: HomeContract.Model) {
        self.model = model
    }
}
