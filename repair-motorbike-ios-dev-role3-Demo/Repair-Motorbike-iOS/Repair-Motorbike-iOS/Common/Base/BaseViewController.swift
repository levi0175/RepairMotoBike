//
//  BaseViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit

protocol BaseViewControllerProtocol: AnyObject {
    // Alert
    func showAlert(title: String?,
                   message: String,
                   titleButton: String,
                   actionButton: (() -> Void)?)
}

extension BaseViewControllerProtocol {
    func showAlert(title: String? = nil,
                   message: String,
                   titleButton: String = Localization.Common.Cancel,
                   actionButton: (() -> Void)? = nil) {
        showAlert(title: title,
                  message: message,
                  titleButton: titleButton,
                  actionButton: actionButton)
    }
    func showAlertOK(title: String? = nil, message: String, titleButton: String = Localization.Common.OK, actionButton: (() -> Void)? = nil) {
        showAlert(title: title,
                  message: message,
                  titleButton: titleButton,
                  actionButton: actionButton)
    }
    
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15, *) {
                        let navigationBarAppearance = UINavigationBarAppearance()
                        navigationBarAppearance.configureWithOpaqueBackground()
                        navigationBarAppearance.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.red
                        ]
                        navigationBarAppearance.backgroundColor = UIColor.white
                        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                    
                    let tabBarApperance = UITabBarAppearance()
                    tabBarApperance.configureWithOpaqueBackground()
                    tabBarApperance.backgroundColor = UIColor.white
                    UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
                    UITabBar.appearance().standardAppearance = tabBarApperance
                }
    }
}

extension BaseViewController {
    func refreshAppGoToAuthenticate() {
        let loginVC = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                                   bundle: nil).instantiateVC(LoginViewController.self)
        loginVC.set(model: LoginModel())
        let authenticateNavController = BaseNavigationController(rootViewController: loginVC)
        UIApplication.shared.windows.first?.rootViewController = authenticateNavController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func refreshAppGoToTabBar() {
        let tabBarController = BaseTabBarController()
        UIApplication.shared.windows.first?.rootViewController = tabBarController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func refreshAppGoToTabBarRole1() {
        let tabBarController = BaseRole1TabbarController()
        UIApplication.shared.windows.first?.rootViewController = tabBarController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

extension BaseViewController: BaseViewControllerProtocol {
    func showAlert(title: String?,
                   message: String,
                   titleButton: String,
                   actionButton: (() -> Void)?) {
        DispatchQueue.main.async {
            let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: titleButton, style: .cancel) { _ in
                if actionButton != nil {
                    actionButton!()
                }
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
