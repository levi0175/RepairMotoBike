//
//  BaseRole1TabbarViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import UIKit

class BaseRole1TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
}

// MARK: - Setup UI
extension BaseRole1TabbarController {
    private func setupUI() {
        setupTabBar()
        setupLogoView()
        setupTintColor()
    }
    
    private func setupTintColor() {
        tabBar.tintColor = AppColor.View.Red
        tabBar.unselectedItemTintColor = AppColor.View.unSelected
        tabBar.backgroundColor = AppColor.View.White
        tabBar.isTranslucent = true
        tabBar.barTintColor = AppColor.View.White
    }
    
    private func setupTabBar() {
        let allBookingVC = UIStoryboard(name: NameConstant.Storyboard.AB, bundle: nil).instantiateVC(AllBookingViewController.self)
        allBookingVC.set(model: AllBookingModel())
        let aBNavController = BaseNavigationController(rootViewController: allBookingVC)
        aBNavController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: AppImage.Image.AB)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: AppImage.Image.AB))
        aBNavController.tabBarItem.tag = 0

        let statusVC = UIStoryboard(name: NameConstant.Storyboard.CustomerLoyal, bundle: nil).instantiateVC(CustomerLoyalViewController.self)
        statusVC.set(model: CustomerLoyalModel())
        let statusNavController = BaseNavigationController(rootViewController: statusVC)
        statusNavController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: AppImage.Image.Status)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
            selectedImage: UIImage(named: AppImage.Image.Status)
        )
        statusNavController.tabBarItem.tag = 1
        
        let notificationVC = UIStoryboard(name: NameConstant.Storyboard.Notification, bundle: nil).instantiateVC(NotificationViewController.self)
        notificationVC.set(model: NotificationModel())
        let notificationNavController = BaseNavigationController(rootViewController: notificationVC)
        notificationNavController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: AppImage.Image.Notification)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
            selectedImage: UIImage(named: AppImage.Image.Notification)
        )
        notificationNavController.tabBarItem.tag = 2
        
        let statisticalVC = UIStoryboard(name: NameConstant.Storyboard.Statistical, bundle: nil).instantiateVC(StatisticalViewController.self)
        statisticalVC.set(model: StatisticalModel())
        let statisticalNavController = BaseNavigationController(rootViewController: statisticalVC)
        statisticalNavController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: AppImage.Image.Stratistical)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
            selectedImage: UIImage(named: AppImage.Image.Stratistical)
        )
        statisticalNavController.tabBarItem.tag = 3
        
        let role1SettingVC = UIStoryboard(name: NameConstant.Storyboard.Role1Setting, bundle: nil).instantiateVC(Role1SettingViewController.self)
        role1SettingVC.set(model: Role1SettingModel())
        let role1SettingNavController = BaseNavigationController(rootViewController: role1SettingVC)
        role1SettingNavController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: AppImage.Image.Role1Setting)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
            selectedImage: UIImage(named: AppImage.Image.Role1Setting)
        )
        role1SettingNavController.tabBarItem.tag = 4
        self.viewControllers = [aBNavController, statusNavController, notificationNavController, statisticalNavController, role1SettingNavController]
    }

    private func setupLogoView() {
        let logoView = UILogoView()
        logoView.startLogoViewAnimation(at: view)
    }
}
