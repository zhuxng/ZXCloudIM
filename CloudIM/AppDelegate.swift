//
//  AppDelegate.swift
//  CloudIM
//
//  Created by 朱星 on 2016/12/6.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit
import AVOSCloud
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,RCIMUserInfoDataSource {

    var window: UIWindow?


    func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
        
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        switch userId {
        case "zhuxing":
            userInfo.name  = "朱星"
            userInfo.portraitUri = "http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg"
        case "zhuxing2":
            userInfo.name  = "小波"
            userInfo.portraitUri = "http://www.poluoluo.com/qq/UploadFiles_7828/201610/2016102120092169.png"
        default:
            ZXLog(message: "没有此用户")
        }
        
        return completion(userInfo)
    }
    
    func customNavgation() {
        UINavigationBar.appearance().barTintColor=UIColor.white
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(CGFloat(NSInteger.min),CGFloat(NSInteger.min)), for:UIBarMetrics.default);
        //.导航标题文字颜色
        UINavigationBar.appearance().titleTextAttributes=NSDictionary(object:UIColor.orange, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject];
        //.将状态栏变为白色
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        //.设置返回按钮颜色
        UINavigationBar.appearance().tintColor=UIColor.orange;
//        //.指定根视图
//        let rootView=NTViewController();
//        self.window!.rootViewController=rootView;
//        self.window!.makeKeyAndVisible();
        //.初始化键盘插件
        
        IQKeyboardManager.sharedManager().enable = true
        
        //let manage:IQKeyboardManager=IQKeyboardManager.sharedManager();
        //manage.enable=true;
        //manage.shouldResignOnTouchOutside=true;
        //manage.shouldToolbarUsesTextFieldTintColor=true;
        //manage.enableAutoToolbar=true;
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        customNavgation()
        
        //获取LeanCload授权
        AVOSCloud.setApplicationId("yQEdWklVxJ0EvvfI0CmxebUz-gzGzoHsz", clientKey: "r1x5GItS6ruNyMxvNJ97j0PL")
        
        //初始化
        RCIM.shared().initWithAppKey("e0x9wycfednoq")
        
        ///设置用户信息提供者
        RCIM.shared().userInfoDataSource = self
        
        //测试token
        RCIM.shared().connect(withToken: "f1UHRS8IAkMxvcEz272FtlPZ8hiukPmpGOYlqEY3U74JwccpmerRX1Sx/HokBl3zejX1cAw/cdR8aA7/QyYh9Q==", success: { (userId) in
            ZXLog(message: "登陆成功。当前登录的用户ID：\(userId)")
            let currentUserInfo = RCUserInfo(userId: "zhuxing", name: "朱星", portrait: "http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg")
            
            RCIMClient.shared().currentUserInfo = currentUserInfo
            
        }, error: { (status) in
            ZXLog(message: status.rawValue)
            
        }) { 
            ZXLog(message: "token不正确或者已经失效")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

