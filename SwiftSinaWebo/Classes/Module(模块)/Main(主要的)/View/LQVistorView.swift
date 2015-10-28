//
//  LQVistorView.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/27.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit
import SnapKit
class LQVistorView: UIView {

    //MARK: -构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
    }
    
    ///准备UI
    func prepareUI(){
        //添加子控件
        addSubview(iconView)
        addSubview(homeView)
        addSubview(messageLabel)
        messageLabel.textAlignment = NSTextAlignment.Center
        addSubview(registerButton)
        addSubview(loginButton)
        
        //设置约束
//        iconView.translatesAutoresizingMaskIntoConstraints = false
//        
//        homeView.translatesAutoresizingMaskIntoConstraints = false
//        
//        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        registerButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        //转轮的约束
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self).offset(0)
            make.centerY.equalTo(self).offset(0)

        }
        
        // 小房子
        
        homeView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self).offset(0)
             make.centerY.equalTo(self).offset(0)
        }
        
        // 消息label
        
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView).offset(0)
            make.centerY.equalTo(iconView.snp_bottom).offset(10)
            make.width.equalTo(250)
        }

        // 注册按钮

        registerButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(messageLabel).offset(0)
            make.top.equalTo(messageLabel.snp_bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }

        // 登录按钮
        
        loginButton.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(messageLabel).offset(0)
            make.top.equalTo(messageLabel.snp_bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
    }
    
    
    // MARK: - 懒加载
    /// 转轮
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        
        // 设置图片
        let image = UIImage(named: "visitordiscover_feed_image_smallicon")
        imageView.image = image
        
        imageView.sizeToFit()
        
        return imageView
        }()
    
    /// 小房子.只有首页有
    private lazy var homeView: UIImageView = {
        let imageView = UIImageView()
        
        // 设置图片
        let image = UIImage(named: "visitordiscover_feed_image_house")
        imageView.image = image
        
        imageView.sizeToFit()
        
        return imageView
        }()
    
    /// 消息文字
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        
        // 设置文字
        label.text = "关注一些人,看看有什么惊喜!"
        
        label.textColor = UIColor.lightGrayColor()
        //自动换行
        label.numberOfLines = 0
        
        label.sizeToFit()
        
        return label
        }()
    
    /// 注册按钮
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        
        // 设置文字
        button.setTitle("注册", forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
        // 设置背景
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        button.sizeToFit()
        
        return button
        }()
    
    /// 登录按钮
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        
        // 设置文字
        button.setTitle("登录", forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
        // 设置背景
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        button.sizeToFit()
        
        return button
        }()


}
