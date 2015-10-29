//
//  LQOauthViewController.swift
//  SwiftSinaWebo
//
//  Created by Tory on 15/10/28.
//  Copyright © 2015年 Tory. All rights reserved.
//

import UIKit
import SVProgressHUD
class LQOauthViewController: UIViewController {

    override func loadView() {
        
        view = webView
        //设置代理
        webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
    
        //加载网页
        let request = NSURLRequest(URL: LQNetworkTools.shareInstance.oauthRUL())
        
        webView.loadRequest(request)
    }
    //关闭控制器
    func close() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    private lazy var webView = UIWebView()
}
// MARK: - 扩展 LQOauthViewController 实现 UIWebViewDelegate 协议
extension LQOauthViewController: UIWebViewDelegate {
    
    //开始加载请求
    func webViewDidStartLoad(webView: UIWebView) {
        //显示正在加载
        //showWhitStatus 不主动关闭，会一直显示
        SVProgressHUD.showWithStatus("正在加载***", maskType: SVProgressHUDMaskType.Gradient)
    }
    
    //加载请求完成
    func webViewDidFinishLoad(webView: UIWebView) {
        //关闭hud
        SVProgressHUD.dismiss()
        
    }
    
    //询问是否加载 request
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.URL!.absoluteString
        
        print("urlString:\(urlString)")
        
        //如果加载的不是回调地址
        if !urlString.hasPrefix(LQNetworkTools.shareInstance.redirect_uri)
        {
            return true //可以加载
        }
        
        if let query = request.URL?.query{
            
            print("query:\(query)")
            let codeString = "code="
            //转成字符串
            let nsQuery = query as NSString
            //判断后边是不是以code=开头
            if query.hasPrefix(codeString)
            {
                
                //截取code值
                let code = nsQuery.substringFromIndex(codeString.characters.count)
                print("code:\(code)")

                //获取access token
                loadAccessToken(code)
                return false
            }else{
                close()
                return false
            }
        }
        return true
    }
    /**
    调用网络工具类去加载加载access token
    - parameter code: code
    */
    func loadAccessToken(code: String)
    {
        LQNetworkTools.shareInstance.loadAccessToken(code) { (result, error) -> () in
            if error != nil || result == nil {
                 print("result: \(result)")
                     print("error: \(error)")
                SVProgressHUD.showErrorWithStatus("网络不给力***", maskType: SVProgressHUDMaskType.Black)
                
                // 延迟关闭. dispatch_after 没有提示,可以拖oc的dispatch_after来修改
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
                    self.close()
                })
                
                return
            }
            print("result: \(result)")
            let account = LQUserAccount(dict: result!)
            
            // 保存到沙盒
            account.saveAccount()
            
            print("account:\(account)")
            
            SVProgressHUD.dismiss()
        }
    }
}
