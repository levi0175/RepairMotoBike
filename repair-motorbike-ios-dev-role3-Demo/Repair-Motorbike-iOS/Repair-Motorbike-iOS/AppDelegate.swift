//
//  AppDelegate.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import UIKit
import GoogleMaps
@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        AppPreferences.shared.getLanguage()
        GMSServices.provideAPIKey("AIzaSyCAvEB9w0zw1kffN5pYYYUud_nyTPLURSo")
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {
            Logger.debug("Unexpected result when app's main window is nil")
            return false
        }

      //  if AppPreferences.shared.getToken() != nil {
            let tabBarController = BaseTabBarController()
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
//        } else {
//                    let loginVC = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
//                                               bundle: nil).instantiateVC(LoginViewController.self)
//                    loginVC.set(model: LoginModel())
//                    let authenticateNavController = BaseNavigationController(rootViewController: loginVC)
//                    window.rootViewController = authenticateNavController
//                    window.makeKeyAndVisible()
//                }
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .list, .sound])
        } else {
            // Fallback on earlier versions
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
