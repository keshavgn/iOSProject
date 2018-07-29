//
//  AppDelegate.swift
//  iOSProject
//
//  Created by Keshav on 13/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import Firebase
import ApiAI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var homeViewController: HomeViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Settings.enableSpotlightSearch(true)
        FirebaseApp.configure()
        setupHomeViewController()
        configureChatBot()
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Swift.Void) {
        setupHomeViewController()
        completionHandler(handleQuickAction(for: shortcutItem))
    }
    
    enum Shortcut: String {
        case login = "Login"
        case pageControl = "Page"
    }
    
    func handleQuickAction(for shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        var quickActionHandled = false
        if let type = shortcutItem.type.components(separatedBy: (".")).last,
            let shortcutType = Shortcut.init(rawValue: type) {
            switch shortcutType {
            case .login:
                homeViewController?.showScreen(0)
                quickActionHandled = true
            case .pageControl:
                homeViewController?.showScreen(3)
            }
        }
        
        return quickActionHandled
    }

    fileprivate func setupHomeViewController () {
        if let controller = self.window?.rootViewController as? UINavigationController,
            let homeViewController = controller.children.first as? HomeViewController {
            self.homeViewController = homeViewController
        }
    }
    
    private func configureChatBot() {
        let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken = "cbce3f1c34d245e5a8edc6aa4130eebb"
        
        let apiai = ApiAI.shared()
        apiai?.configuration = configuration
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
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.sharedInstance.saveContext()
    }
}

