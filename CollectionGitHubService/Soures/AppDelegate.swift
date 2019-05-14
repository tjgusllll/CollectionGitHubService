//
//  AppDelegate.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 13/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupKeyWindow()
        return true
    }

}

extension AppDelegate {
    private func setupKeyWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let allUserViewController = ProvideObject.allUser.viewController
        window?.rootViewController = UINavigationController(rootViewController: allUserViewController)
        window?.makeKeyAndVisible()
    }
}

