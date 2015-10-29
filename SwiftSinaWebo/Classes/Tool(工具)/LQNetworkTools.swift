//
//  LQNetworkTools.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/28.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit
import AFNetworking
//修改继承
class LQNetworkTools: AFHTTPSessionManager {

    
    //创建单例
    static let shareInstance: LQNetworkTools = {
        let urlString = "https://api.weibo.com/"
        
        let tool = LQNetworkTools(baseURL: NSURL(string: urlString))
        //添加解析方式
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")

        
        return tool
    }()
    
    // MARK: - OAtuh授权
    /// 申请应用时分配的AppKey
    private let client_id = "1848560358"
    
    /// 申请应用时分配的AppSecret
    private let client_secret = "7d6a79d2a13581d23a8baef2ff5c2386"
    
    /// 请求的类型，填写authorization_code
    private let grant_type = "authorization_code"
    
    /// 回调地址
    let redirect_uri = "http://www.baidu.com/"
    
    // OAtuhURL地址
    func oauthRUL() -> NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)"
        return NSURL(string: urlString)!
    }
    // 使用闭包回调
    // MARK: - 加载AccessToken
    /// 加载AccessToken
    func loadAccessToken(code: String, finshed: (result: [String: AnyObject]?, error: NSError?) -> ()) {
        // url
        let urlString = "oauth2/access_token"
        
        // NSObject
        // AnyObject, 任何 class
        // 参数
        let parameters = [
            "client_id": client_id,
            "client_secret": client_secret,
            "grant_type": grant_type,
            "code": code,
            "redirect_uri": redirect_uri
        ]
        
        // 测试返回结果类型
        //        responseSerializer = AFHTTPResponseSerializer()
        // result: 请求结果
        POST(urlString, parameters: parameters, success: { (_, result) -> Void in
            
//                        let data = String(data: result as! NSData, encoding: NSUTF8StringEncoding)
//                        print("data: \(data)")
            
            finshed(result: result as? [String: AnyObject], error: nil)
            }) { (_, error: NSError) -> Void in
                finshed(result: nil, error: error)
        }
    }

}
