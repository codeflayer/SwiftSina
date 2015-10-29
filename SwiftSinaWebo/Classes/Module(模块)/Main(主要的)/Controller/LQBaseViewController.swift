//
//  LQBaseViewController.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/26.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit

class LQBaseViewController: UITableViewController {

    // 当实现这个方,并且给view设置值,不会再从其他地方加载view.xib storyboard
    /*
    在 loadView，如果:
    1.设置view的值,使用设置的view
    2.super.loadView() 创建TableView
    
    */
    
    let userLogin = false
    
    override func loadView() {
        userLogin ? super.loadView() : setupVisitorView()
    }
    ///创建访客视图
    func setupVisitorView()
    {   let vistorView = LQVistorView()
        view = vistorView
        
        vistorView.vistorViewDelegte = self
//        view.backgroundColor = UIColor.grayColor()
        // 设置导航栏
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "vistorViewRegistClick")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "vistorViewLoginClick")
        //判断是哪个页面
        if self is LQHomeViewController {
//            //开始动画
            vistorView.startRotationAnimation()
            
                // 监听应用退到后台,和进入前台
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEnterBackground", name: UIApplicationDidEnterBackgroundNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "didBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)

        } else if self is LQMegViewController {
            vistorView.setupVistorView("visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
        } else if self is LQDisViewController {
            vistorView.setupVistorView("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        } else if self is LQProViewController {
            vistorView.setupVistorView("visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        }

    }
    // MAKR: - 通知方法
    func didEnterBackground() {
        // 暂停动画
        (view as! LQVistorView).pauseAnimation()
    }
    
    func didBecomeActive() {
        // 继续动画
        (view as! LQVistorView).resumeAnimation()
    }
}
// MARK: - 扩展 CZBaseTableViewController 实现 CZVistorViewDelegte 协议
//相当于 category, 方便代码的管理
extension LQBaseViewController: LQVistorViewDelegte {
    // MARK: - 代理方法
         
    func vistorViewRegistClick() {
        print(__FUNCTION__)
    }
    
    func vistorViewLoginClick() {
        let view = LQOauthViewController()
        
        presentViewController(UINavigationController(rootViewController: view), animated: true, completion: nil)
    }
}
