//
//  AppDelegate.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 06/07/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import FBSDKCoreKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config =  Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 2) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })

        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
        
        FirebaseApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 80

        window = UIWindow(frame: UIScreen.main.bounds)

        if (Auth.auth().currentUser == nil && !FBSDKAccessToken.currentAccessTokenIsActive() ) {
            let loginViewController = ControllersFactory.allocController(.MainCtrl) as! MainViewController
            window?.rootViewController = loginViewController
        } else {
            let slideMenuViewController = ControllersFactory.allocController(.SlideMenuCtrl) as! SlideMenuViewController
            window?.rootViewController = slideMenuViewController 
        }
        window?.makeKeyAndVisible()

        
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

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
       
        let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: UIApplication.OpenURLOptionsKey.annotation)
        
        return handled
    }
}

