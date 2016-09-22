//
//  AppDelegate.swift
//  DouBanRadio
//
//  Created by WENGzhang on 27/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //开启后台处理多媒体事件
        //[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        UIApplication.shared.beginReceivingRemoteControlEvents();
        let session = AVAudioSession.sharedInstance();
        do {try session.setActive(true);
        }catch{
        }
        //后台播放
        do {try session.setCategory(AVAudioSessionCategoryPlayback);
        }catch{
        }
        //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
        let _bgTaskId = UIBackgroundTaskInvalid;
        var bgTaskId = AppDelegate.backgroundPlayerID(backTaskId: _bgTaskId);
//        其中的_bgTaskId是后台任务UIBackgroundTaskIdentifier _bgTaskId;
        
    
    }
    //实现一下backgroundPlayerID:这个方法:
    class func backgroundPlayerID(backTaskId:UIBackgroundTaskIdentifier) ->UIBackgroundTaskIdentifier
    {
    //设置并激活音频会话类别
    let session=AVAudioSession.sharedInstance();
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
        }catch{
        };
        do {try session.setActive(true)
        }catch{
        };
    //允许应用程序接收远程控制
   UIApplication.shared.beginReceivingRemoteControlEvents();
    //设置后台任务ID
    var  newTaskId = UIBackgroundTaskInvalid;
         newTaskId = UIApplication.shared.beginBackgroundTask(expirationHandler: nil);
        
    if(newTaskId != UIBackgroundTaskInvalid && backTaskId != UIBackgroundTaskInvalid)
    {
    UIApplication.shared.endBackgroundTask(backTaskId);
    }
    return newTaskId;
    }
    

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

