//
//  LQUserAccount.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/29.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit
/*
iOS保存数据的方式:
1.plist
2.偏好设置
3.归档
4.sqlite
5.CoreData
*/
class LQUserAccount: NSObject ,NSCoding {
    
    // 当做类方法. 返回值就是属性的类型
    // 有账号返回true
    class func userLogin() -> Bool {
        return LQUserAccount.loadAccount() != nil
    }
    /// 用于调用access_token，接口获取授权后的access token
    var access_token: String?
    
    /// access_token的生命周期，单位是秒数
    /// 对于基本数据类型不能定义为可选
    var expires_in: NSTimeInterval = 0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
            print("expires_date:\(expires_date)")
        }
    }
    /// 当前授权用户的UID
    var uid: String?
    
    ///过期时间
    var expires_date: NSDate?
    
    //友好显示名称
    var name: String?
        //用户头像
    var avatar_large: String?
    
    // KVC 字典转模型
    init(dict: [String: AnyObject]) {
        
        super.init()
        // 将字典里面的每一个key的值赋值给对应的模型属性
        setValuesForKeysWithDictionary(dict)
    }
    // 当字典里面的key在模型里面没有对应的属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        return "access_token:\(access_token), expires_in:\(expires_in), uid:\(uid): expires_date:\(expires_date), name:\(name), avatar_large:\(avatar_large)"
    }
    // MARK: - 加载用户信息
    //控制调用这个方法，不管成功还是失败都要告诉调用者
    func loadUserInfo(finshed: (error: NSError?)->()){
        LQNetworkTools.shareInstance.loadUserInfo { (result, error) -> () in
            if error != nil || result == nil {
                finshed(error: error)
                return
            }
            print("result:(\result)")
            //加载成功之后
            
            self.name = result!["name"] as? String
            self.avatar_large = result!["avatar_large"] as? String
            
            //保存到沙盒
            self.saveAccount()
            
            //同步到内存中，把当前的对象赋值给内存中的userAccount
            LQUserAccount.userAccount = self
            finshed(error: nil)
        }
    }
    
    
    // 类方法访问属性需要将属性定义成 static
    // 对象方法访问static属性需要类名.属性名称
    static let accountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! + "/Account.plist"
    
    // MARK: - 保存对象
    func saveAccount() {
        // account.plist
        
        NSKeyedArchiver.archiveRootObject(self, toFile: LQUserAccount.accountPath)
    }
    
    // 类方法访问属性需要将属性定义成 static
    private static var userAccount: LQUserAccount?
    
    // 加载loadAccount 是用频繁,解档账号比较耗性能,只加载一次,保存到内存中,以后访问内存的中账号
    class func loadAccount() -> LQUserAccount? {
        
        // 判断内存有没有
        if userAccount == nil {
            // 内存中没有才来解档,并赋值给内存中的账号
            userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? LQUserAccount
        }
        //判断有没有效，时间
        if userAccount != nil && userAccount?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending {

            return userAccount
        }
        
        return nil
    }
    
    // MARK: - 归档和解档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")

    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
    }



}
