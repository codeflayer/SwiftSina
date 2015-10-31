//
//  LQHomeTitleButton.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/31.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit

class LQHomeTitleButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        //改变箭头的位置
        titleLabel?.frame.origin.x = 0
        
        imageView?.frame.origin.x = titleLabel!.frame.width + 3
        
    }
}
