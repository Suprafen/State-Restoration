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

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("AppDelegate willFinishLaunchingWithOptions")

        // This probably shouldn't be run under iOS 13?
        self.window = UIWindow(frame: UIScreen.main.bounds)

        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("AppDelegate didFinishLaunchingWithOptions")

        if #available(iOS 13.0, *) {
            // What needs to be here?
        } else {
            // If the root view controller wasn't restored, create a new one from scratch
            if (self.window?.rootViewController == nil) {
                let vc = ViewController()
                let nc = UINavigationController(rootViewController: vc)
                nc.restorationIdentifier = "RootNC"

                self.window?.rootViewController = nc
            }

            self.window?.makeKeyAndVisible()
        }

        return true
    }

    func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        if #available(iOS 13, *) {

        } else {
            print("AppDelegate viewControllerWithRestorationIdentifierPath")

            // If this is for the nav controller, restore it and set it as the window's root
            if identifierComponents.first == "RootNC" {
                let nc = UINavigationController()
                nc.restorationIdentifier = "RootNC"
                self.window?.rootViewController = nc

                return nc
            }
        }
        return nil
    }

    func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        print("AppDelegate willEncodeRestorableStateWith")
        if #available(iOS 13, *) {

        } else {
        // Trigger saving of the root view controller
            coder.encode(self.window?.rootViewController, forKey: "root")
        }
    }

    func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        print("AppDelegate didDecodeRestorableStateWith")
    }

    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        print("AppDelegate shouldSaveApplicationState")
        if #available(iOS 13, *) {
            return false
        } else {
            return true
        }
    }

    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        print("AppDelegate shouldRestoreApplicationState")
         if #available(iOS 13, *) {
             return true
         } else {
             return true
         }
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

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("AppDelegate didDiscardSceneSessions")
    }
}
