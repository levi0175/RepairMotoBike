//
//  BaseTabBarController.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI
extension BaseTabBarController {
    private func setupUI() {
        setupTabBar()
        setupLogoView()
        setupTintColor()
    }
    
    private func setupTintColor() {
        tabBar.tintColor = AppColor.View.Red
        tabBar.unselectedItemTintColor = AppColor.Label.TitleLabel
        tabBar.backgroundColor = AppColor.View.White
        tabBar.isTranslucent = true
        tabBar.barTintColor = AppColor.View.White
    }
    
    private func setupTabBar() {
        let homeVC = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(HomeGarageViewController.self)
        homeVC.set(model: HomeGarageModel())
        let homeNavController = BaseNavigationController(rootViewController: homeVC)
        homeNavController.tabBarItem = UITabBarItem(title: NameConstant.Storyboard.TrangChu,
                                                    image: UIImage(named: AppImage.Image.Home)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                    selectedImage: UIImage(named: AppImage.Image.Home))
        homeNavController.tabBarItem.tag = 0

        let CalenderVC = UIStoryboard(name: NameConstant.Storyboard.Schedule, bundle: nil).instantiateVC(ScheduleViewController.self)
        CalenderVC.set(model: ScheduleModel())
        let calenderNavController = BaseNavigationController(rootViewController: CalenderVC)
        calenderNavController.tabBarItem = UITabBarItem(
            title: NameConstant.Storyboard.DatLich,
            image: UIImage(named: AppImage.Image.Notification)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
            selectedImage: UIImage(named: AppImage.Image.Notification)
        )
        calenderNavController.tabBarItem.tag = 1
        
        let settingVC = UIStoryboard(name: NameConstant.Storyboard.Setting,
                                     bundle: nil).instantiateVC(SettingViewController.self)
        settingVC.set(model: SettingModel())
        let settingNavController = BaseNavigationController(rootViewController: settingVC)
        settingNavController.tabBarItem = UITabBarItem(
            title: NameConstant.Storyboard.CaiDat,
            image: UIImage(named: AppImage.Image.Profile)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
            selectedImage: UIImage(named: AppImage.Image.Profile)
        )
        settingNavController.tabBarItem.tag = 2
        
        self.viewControllers = [homeNavController, calenderNavController, settingNavController]
    }

    private func setupLogoView() {
        let logoView = UILogoView()
        logoView.startLogoViewAnimation(at: view)
    }
}
