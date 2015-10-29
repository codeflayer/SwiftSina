//
//  LQVistorView.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/27.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit
import SnapKit


//定义协议
protocol LQVistorViewDelegte: NSObjectProtocol {
    
    //注册按钮
    func vistorViewRegistClick()
    
    func vistorViewLoginClick()
}
class LQVistorView: UIView {
    
    //代理
    weak var vistorViewDelegte: LQVistorViewDelegte?
    
    
    
    //MARK: -构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented)")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
    }
    func setupVistorView(imageName: String, message: String){
        //隐藏房子
        homeView.hidden = true
        
        iconView.image = UIImage(named: imageName)
        
        messageLabel.text = message
        //将遮罩移到后面
        self.sendSubviewToBack(coverView)
    }
    ///准备UI
    func prepareUI(){
        //添加子控件
        addSubview(iconView)
        addSubview(coverView)
        addSubview(homeView)
        addSubview(messageLabel)
        messageLabel.textAlignment = NSTextAlignment.Center
        addSubview(registerButton)
        addSubview(loginButton)
        // 背景颜色
        backgroundColor = UIColor(white: 237 / 255, alpha: 1)
        
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
        //遮盖
        
        coverView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.snp_width).offset(0)
            make.top.equalTo(self.snp_top).offset(0)
            make.bottom.equalTo(self.snp_bottom).offset(-180)
            
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
    //设置动画
    func startRotationAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.duration = 20
        animation.repeatCount = MAXFLOAT
        
        // 要加上这句,不然切换到其他tabBar或者退出到桌面在切回来动画就停止了
        animation.removedOnCompletion = false
        
        iconView.layer.addAnimation(animation, forKey: "homeRotation")
    }
    
    /// 暂停旋转
    func pauseAnimation() {
        // 记录暂停时间
        let pauseTime = iconView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        
        // 设置动画速度为0
        iconView.layer.speed = 0
        
        // 设置动画偏移时间
        iconView.layer.timeOffset = pauseTime
    }
    
    /// 恢复旋转
    func resumeAnimation() {
        // 获取暂停时间
        let pauseTime = iconView.layer.timeOffset
        
        // 设置动画速度为1
        iconView.layer.speed = 1
        
        iconView.layer.timeOffset = 0
        
        iconView.layer.beginTime = 0
        
        let timeSincePause = iconView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pauseTime
        
        iconView.layer.beginTime = timeSincePause
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
        
        button.addTarget(self, action: "registClick", forControlEvents: UIControlEvents.TouchUpInside)
        
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
        
        button.addTarget(self, action: "loginClick", forControlEvents: UIControlEvents.TouchUpInside)
        button.sizeToFit()
        
        return button
        }()
    
        //遮盖
    
    private lazy var coverView: UIImageView = {
        let imageView = UIImageView()
       
        let image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        
        imageView.image = image
        
        return imageView
    }()
    
    //注册事件
    func registClick() {
        // ? 前面的变量有值才执行后面的代码,没有值就什么都不做
        vistorViewDelegte?.vistorViewRegistClick()
    }
    
    //登录事件
    func loginClick() {
        vistorViewDelegte?.vistorViewLoginClick()
    }

    

}
