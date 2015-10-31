//
//  LQHomeViewController.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/26.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit

class LQHomeViewController: LQBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !LQUserAccount.userLogin()
        {
            return
        }
        setupNavigaiotnBar()
    }
    private func setupNavigaiotnBar(){
        //添加首页导航栏按钮，使用了类扩展：UIBarButtonItem+Extension.swift
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        //获取用户名,??代表如果前面的值没有就赋值后面的
        let name = LQUserAccount.loadAccount()?.name ?? "无名氏"
        
        //设置title
        let button = LQHomeTitleButton()
        
        button.setTitle(name, forState: UIControlState.Normal)
        button.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.sizeToFit()
        
        button.addTarget(self, action: "homeButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.titleView = button
    }
    //前面+@objc 访问权限问题
    @objc private func homeButtonClick(button: UIButton){
        button.selected = !button.selected
        
        //设置动画
        var transform: CGAffineTransform
        if button.selected {
            transform = CGAffineTransformMakeRotation(CGFloat(M_PI - 0.01))
        }else{
            transform = CGAffineTransformIdentity
        }
        
        UIView.animateWithDuration(0.25) { () -> Void in
            button.imageView?.transform = transform
        }
        
    }
}
