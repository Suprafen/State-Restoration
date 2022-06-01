//
//  AppDelegate.swift
//  UIRestoration-Playground
//
//  Created by Ivan Pryhara on 28.05.22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("AppDelegate didFinishLaunchingWithOptions")

        return true
    }

    // The following four are not called in iOS 13
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("AppDelegate applicationWillEnterForeground")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("AppDelegate applicationDidEnterBackground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("AppDelegate applicationDidBecomeActive")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("AppDelegate applicationWillResignActive")
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print("AppDelegate configurationForConnecting")

        var sceneConfig = connectingSceneSession.configuration
        return sceneConfig
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("AppDelegate didDiscardSceneSessions")
    }

    
    func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        true
    }

    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        true
    }
}
