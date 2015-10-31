//
//  LQNetworkTools.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/28.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit
import AFNetworking
// MARK: - 网络错误枚举
enum LQNetworkError: Int {
    case emptyToken = -1
    case emptyUid = -2
    
    // 枚举里面可以有属性
    var description: String {
        get {
            // 根据枚举的类型返回对应的错误
            switch self {
            case LQNetworkError.emptyToken:
                return "accecc token 为空"
            case LQNetworkError.emptyUid:
                return "uid 为空"
            }
        }
    }
    
    // 枚举可以定义方法
    func error() -> NSError {
        return NSError(domain: "cn.itcast.error.network", code: rawValue, userInfo: ["errorDescription" : description])
    }
}

//修改继承
class LQNetworkTools: NSObject {
    
    // 类型别名 = typedefined
    typealias NetworkFinishedCallback = (result: [String: AnyObject]?, error: NSError?) -> ()
    
    //属性
    private var afnManager: AFHTTPSessionManager
    //创建单例
    static let shareInstance: LQNetworkTools = LQNetworkTools()
        
        override init(){
            
        let urlString = "https://api.weibo.com/"
        
//        let tool = LQNetworkTools(baseURL: NSURL(string: urlString))
            afnManager = AFHTTPSessionManager(baseURL: NSURL(string: urlString))
            
        //添加解析方式
        afnManager.responseSerializer.acceptableContentTypes?.insert("text/plain")

    }
    
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
    func loadAccessToken(code: String, finshed: NetworkFinishedCallback) {
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
        afnManager.POST(urlString, parameters: parameters, success: { (_, result) -> Void in
            

            
            finshed(result: result as? [String: AnyObject], error: nil)
            }) { (_, error: NSError) -> Void in
                finshed(result: nil, error: error)
        }
    }
    
    // MARK: - 获取用户信息
    func loadUserInfo(finshed: NetworkFinishedCallback){
            
            //判断accessToken
            if LQUserAccount.loadAccount()?.access_token == nil {
                let error = LQNetworkError.emptyToken.error()
                //告诉调用者
                finshed(result: nil, error: error)
                return
            }
            //判断uid
            if LQUserAccount.loadAccount()?.uid == nil {
                let error = LQNetworkError.emptyToken.error()
                //告诉调用者
                finshed(result: nil, error: error)
                return
            }
            
            //设置url
            let urlString = "https://api.weibo.com/2/users/show.json"
            
            //参数
            let parameters = [
                //必须拆包
                "access_token": LQUserAccount.loadAccount()!.access_token!,
                "uid": LQUserAccount.loadAccount()!.uid!
            ]
            
//           afnManager.GET(urlString, parameters: parameters, success: { (_, result) -> Void in
//                            finshed(result: result as? [String: AnyObject], error: nil)
//                            }) { (_, error) -> Void in
//                                finshed(result: nil, error: error)
//            }
            requestGET(urlString, parameters: parameters, finshed: finshed)
    }
            // MARK: - 封装AFN.GET
            func requestGET(URLString: String, parameters: AnyObject?, finshed: NetworkFinishedCallback) {
                
                afnManager.GET(URLString, parameters: parameters, success: { (_, result) -> Void in
                    finshed(result: result as? [String: AnyObject], error: nil)
                    }) { (_, error) -> Void in
                        finshed(result: nil, error: error)
                }
    }
}
















