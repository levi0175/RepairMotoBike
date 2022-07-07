//
//  HomeGarageTableViewCell.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 21/05/2022.
//

import UIKit

class HomeGarageTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var sliderCollectionView: UICollectionView!
    @IBOutlet private weak var pageView: UIPageControl!
    
    private var timer = Timer()
    private var counter = 0
    private var imgArrSlideShow = [UIImage(named: AppImage.Image.slide1), UIImage(named: AppImage.Image.slide2), UIImage(named: AppImage.Image.slide3), UIImage(named: AppImage.Image.slide4), UIImage(named: AppImage.Image.slide5)]
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        handleSlideShow()
    }
    private func setupCollectionView() {
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.registerCellNib1(type: SlideShowHomeCell.self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
extension HomeGarageTableViewCell {
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
// MARK: - Setup CollectionView
extension HomeGarageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imgArrSlideShow.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        guard let cell = collectionView.dequeueReusableCellNib(type: SlideShowHomeCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }

        cell.config(data: imgArrSlideShow[indexPath.row]!)
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        counter = indexPath.row
        pageView.currentPage = counter
    }
}

extension HomeGarageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeSlider = sliderCollectionView.frame.size
        return CGSize(width: sizeSlider.width, height: sizeSlider.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
        0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}
