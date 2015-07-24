//
//  AppDelegate.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 4/16/15.
//  Copyright (c) 2015 Jin Seok Park. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.setApplicationId("6paxaupe1USWzy1MSwG01qAcxQgZr2f3hDfjZTlt",
            clientKey: "sW4z6eSZBqxEY5BA2TQEM2BRvm6nFsOfzYxcF2Vc")
        
        
        // Register for Push Notitications
        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.
            
            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var pushPayload = false
            if let options = launchOptions {
                pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
            }
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
                
                PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground([NSObject : AnyObject]?(), block: { (Bool, NSError) -> Void in
                    
                })
            }
        }
        if application.respondsToSelector("registerUserNotificationSettings:") {
            let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
            application.registerForRemoteNotificationTypes(types)
        }
        
        
        
        
        
        
        
        
        //        let notificationTypes:UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        //        let notificationSettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes:notificationTypes, categories: nil)
        //        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        //        let testObject:PFObject = PFObject(className: "TestClass")
        //        testObject["SomeProperty"] = "SomeValue"
        //        testObject.saveInBackgroundWithBlock(nil)
        
        return true
    }
    
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackgroundWithBlock { (Bool, NSError) -> Void in
            
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            println("Push notifications are not supported in the iOS Simulator.")
        } else {
            println("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayloadInBackground([NSObject : AnyObject]?(), block: { (Bool, NSError) -> Void in
                
            })
        }
    }
    
    //    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
    //
    //        UIApplication.sharedApplication().registerForRemoteNotifications()
    //    }
    //
    //    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    //
    //        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
    //        currentInstallation.setDeviceTokenFromData(deviceToken)
    //        currentInstallation.saveInBackgroundWithBlock { (succeeded:Bool, error:NSError?) -> Void in
    //
    //            println("install complete")
    //        }
    //    }
    //
    //    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    //
    //        println(error.localizedDescription)
    //    }
    //
    //    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    //
    //        NSNotificationCenter.defaultCenter().postNotificationName("getMessage", object: nil)
    //        NSNotificationCenter.defaultCenter().postNotificationName("getGroupMessage", object: nil)
    //        PFPush.handlePush(userInfo)
    //
    //    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

