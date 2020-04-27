//
//  AppDelegate.swift
//  WIIPhotoPickerController
//
//  Created by freshera on 2020/4/26.
//  Copyright © 2020 wiseinfoiotDev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        
        let controller = ViewController()
        let nav = UINavigationController(rootViewController: controller)
        self.window?.rootViewController = nav
        return true
    }

}

