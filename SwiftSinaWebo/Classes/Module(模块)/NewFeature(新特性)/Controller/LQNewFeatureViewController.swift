//
//  LQNewFeatureViewController.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/31.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LQNewFeatureViewController: UICollectionViewController {
    
    // MARK: - 属性
    //页数
    private let itemCount = 4
    
    //创建layout
    private var layout = UICollectionViewFlowLayout()//流水布局
    
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册的时候记得修改成自定义的cell
        self.collectionView!.registerClass(LQNewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        prepareLayout()

        // Do any additional setup after loading the view.
    }

    // MARK: - 设置layout的参数
    private func prepareLayout() {
        
        //设置item的大小
        layout.itemSize = UIScreen.mainScreen().bounds.size
        //间距为0
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        //滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal //水平防线滚动
        
        //分页功能
        collectionView?.pagingEnabled = true
        
        //取消页面弹簧效果
        collectionView?.bounces = false
    }



    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! LQNewFeatureCell
        
        cell.imageIndex = indexPath.item
        
        
        return cell
    }

    // collectionView显示完毕cell
    // collectionView分页滚动完毕cell看不到的时候调用
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        // 正在显示的cell的indexPath
        let showIndexPath = collectionView.indexPathsForVisibleItems().first!
        
        // 获取collectionView正在显示的cell
        let cell = collectionView.cellForItemAtIndexPath(showIndexPath) as! LQNewFeatureCell
        
        // 最后一页动画
        if showIndexPath.item == itemCount - 1 {
            // 开始按钮动画
            cell.startButtonAnimation()
        }
    }

    
}

// 自定义cell
class LQNewFeatureCell: UICollectionViewCell {
    // MARK: - 懒加载
    /// 背景
    private lazy var backgroundImageView = UIImageView()
    
    /// 开始体验按钮
    private lazy var startButton: UIButton = {
        let button = UIButton()
        
        // 设置按钮背景
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        
        // 设置文字
        button.setTitle("开始体验", forState: UIControlState.Normal)
        
        // 添加点击事件
        button.addTarget(self, action: "startButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
        }()

    // MARK: 属性
    // 监听属性值的改变, cell 即将显示的时候会调用
    var imageIndex: Int = 0 {
        didSet {
            // 知道当前是哪一页
            // 设置图片
            backgroundImageView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            
            startButton.hidden = true
        }
    }
    // MARK: - 构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
    }
    
    // MARK: - 准备UI
    private func prepareUI() {
        // 添加子控件
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(startButton)
        
        // 添加约束
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        // VFL
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bkg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bkg" : backgroundImageView]))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[bkg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bkg" : backgroundImageView]))
        
        // 开始体验按钮
        contentView.addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -160))
    }
    
    // 点击事件
    func startButtonClick() {
        (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootController(true)
    }
    
    // MARK: - 开始按钮动画
    func startButtonAnimation() {
        startButton.hidden = false
        // 把按钮的 transform 缩放设置为0
        startButton.transform = CGAffineTransformMakeScale(0, 0)
        
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startButton.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                
        }
    }

}