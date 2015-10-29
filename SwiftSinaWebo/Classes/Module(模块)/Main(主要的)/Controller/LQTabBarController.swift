//
//  LQTabBarController.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/26.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit

class LQTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //自定义tabBar，使用kvc给只读的tabBar赋值。
        let newTabBar = LQTabBar()
        
        newTabBar.composeButton.addTarget(self, action: "composeButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
//         使用KVC
        setValue(newTabBar, forKey: "tabBar")
        tabBar.tintColor = UIColor.orangeColor()
        
        //首页
        let homeVc = LQHomeViewController()
        self.addChildViewController(homeVc, title: "首页", imageName: "tabbar_home", selImageName: "tabbar_home_highlighted")

        
        //消息
        let megVc = LQMegViewController()
        self.addChildViewController(megVc, title: "消息", imageName: "tabbar_message_center", selImageName: "tabbar_message_center_highlighted")
        
        //发现
        let disVc = LQDisViewController()
        self.addChildViewController(disVc, title: "发现", imageName: "tabbar_discover", selImageName: "tabbar_discover_highlighted")

    
        //我
        let proVc = LQProViewController()
        self.addChildViewController(proVc, title: "我", imageName: "tabbar_profile", selImageName: "tabbar_profile_highlighted")

        
        

    }

    func composeButtonClick()
    {
        
    }
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let width = tabBar.bounds.size.width / CGFloat(5)
//        
//        composeButton.frame = CGRect(x: width * 2, y: 0, width: width, height: tabBar.bounds.height)
//        tabBar.addSubview(composeButton)
//        
    
        
//    }
    ///创建子控制器的方法。
    private func addChildViewController(viewController: UIViewController, title: String, imageName: String, selImageName: String) {
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        viewController.tabBarItem.selectedImage = UIImage(named: selImageName)
       addChildViewController(UINavigationController(rootViewController: viewController))
    }
//    // MARK: - 懒加载
//    /// 撰写按钮
//    lazy var composeButton: UIButton = {
//        let button = UIButton()
//        
//        // 按钮图片
//        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
//        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
//        
//        // 按钮的背景
//        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
//        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
//        
//        button.addTarget(self, action: "composeButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        return button
//        }()
//
}
