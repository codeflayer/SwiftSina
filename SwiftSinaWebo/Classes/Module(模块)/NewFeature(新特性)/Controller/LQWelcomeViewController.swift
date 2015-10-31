//
//  LQWelcomeViewController.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/29.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit
import SDWebImage
import SceneKit
class LQWelcomeViewController: UIViewController {
    
    // MARK: - 属性
    /// 头像底部约束
    private var iconViewBottomCons: NSLayoutConstraint?
    
    // MARK: - 懒加载
    /// 头像
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar_default_big"))
        
        // 切成圆
        imageView.layer.cornerRadius = 42.5
        imageView.layer.masksToBounds = true
        
        return imageView
        }()

    //背景
    private lazy var backgorundImageView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    //lable欢迎回来
    private lazy var welcomeLabel: UILabel = {
        let lable = UILabel()
        
        lable.text = "欢迎回来"
        lable.alpha = 0
        return lable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        if let urlString = LQUserAccount.loadAccount()?.avatar_large {
            //设置用户头像
            iconView.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "avatar_default_big"))
        }
    }


    
    // MARK: - 准备UI
    private func prepareUI() {
        //添加子控制器
        
        view.addSubview(backgorundImageView)
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        backgorundImageView.backgroundColor = UIColor.blackColor()
        
        //添加约束
        // 添加约束
        backgorundImageView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //背景
        backgorundImageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }

        
        //头像
        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
        // 垂直 底部160
        iconViewBottomCons = NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -160)
        view.addConstraint(iconViewBottomCons!)
        //欢迎归来
        welcomeLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp_bottom).offset(16)
        }
        
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 开始动画
        iconViewBottomCons?.constant = -(UIScreen.mainScreen().bounds.height - 160)
        
        // usingSpringWithDamping: 值越小弹簧效果越明显 0 - 1
        // initialSpringVelocity: 初速度
        UIView.animateWithDuration(1.0, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.welcomeLabel.alpha = 1
                    }, completion: { (_) -> Void in
                        (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootController(true)
                })
        }
    }

}
