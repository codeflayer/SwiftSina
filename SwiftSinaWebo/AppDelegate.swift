//
//  AppDelegate.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/26.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        print("account:\(LQUserAccount.loadAccount())")
//        print("account:\(account)")
//        print("account:\(account)")
        setupAppearance()
        //创建windows
//        let tabBarVc = LQTabBarController()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.rootViewController = LQNewFeatureViewController()
        
//        window?.backgroundColor = UIColor.redColor()
        
        window?.makeKeyAndVisible()
        return true
    }
    private func defaultController() -> UIViewController {
        // 判断是否登录
        // 每次判断都需要 == nil
        if !LQUserAccount.userLogin() {
            return LQTabBarController()
        }
        
        
        // 判断是否是新版本
        return isNewVersion() ? LQNewFeatureViewController() : LQWelcomeViewController()
    }
    
    /// 判断是否是新版本
    private func isNewVersion() -> Bool {
        // 获取当前的版本号
        let versionString = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let currentVersion = Double(versionString)!
        print("currentVersion: \(currentVersion)")
        
        // 获取到之前的版本号
        let sandboxVersionKey = "sandboxVersionKey"
        let sandboxVersion = NSUserDefaults.standardUserDefaults().doubleForKey(sandboxVersionKey)
        print("sandboxVersion: \(sandboxVersion)")
        
        // 保存当前版本号
        NSUserDefaults.standardUserDefaults().setDouble(currentVersion, forKey: sandboxVersionKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // 对比
        return currentVersion > sandboxVersion
    }

    // MARK: - 切换根控制器
    
    /**
    切换根控制器
    - parameter isMain: true: 表示切换到MainViewController, false: welcome
    */
    func switchRootController(isMain: Bool) {
        window?.rootViewController = isMain ? LQTabBarController() : LQWelcomeViewController()
    }
    private func setupAppearance() {
        // 尽早设置
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

