//
//  SceneDelegate.swift
//  UIRestoration-Playground
//
//  Created by Ivan Pryhara on 28.05.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("SceneDelegate willConnectTo")

        guard let winScene = (scene as? UIWindowScene) else { return }

        // Got some of this from WWDC2109 video 258

        print("User activities from connection options: ",connectionOptions.userActivities.first?.userInfo)
        print("Session.stateRestorationActivity: \(session.stateRestorationActivity?.userInfo)")
        
        // userActivities == nil ????
        guard let userActivity = connectionOptions.userActivities.first ??  session.stateRestorationActivity else {
            window = UIWindow(windowScene: winScene)
            let vc = ViewController()
            let nc = UINavigationController(rootViewController: vc)
            window?.makeKeyAndVisible()

            self.window?.rootViewController = nc
            
            return
        }
        
        window = UIWindow(windowScene: winScene)
        if configure(window: window, session: session, with: userActivity) {
            scene.userActivity = userActivity
            // assume we finished with this
        }
    }

    func configure(window: UIWindow?, session: UISceneSession, with activity: NSUserActivity) -> Bool {
        var succeeded = false
        
        
        let vc = ViewController()
        let nc = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()

        self.window?.rootViewController = nc
        
        let childViewController = ChildViewController()
        if let userInfo = activity.userInfo {
            if let navigationController = window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(childViewController, animated: false)
            }
            succeeded = true
        }
            
        return succeeded
    }
    
    func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        print("SceneDelegate didUpdate")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("SceneDelegate sceneDidDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("SceneDelegate sceneDidBecomeActive")
        
        if let userActivity = window?.windowScene?.userActivity {
            userActivity.becomeCurrent()
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("SceneDelegate sceneWillResignActive")
        
        if let userActivity = window?.windowScene?.userActivity {
            userActivity.resignCurrent()
        }
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("SceneDelegate sceneWillEnterForeground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("SceneDelegate sceneDidEnterBackground")
    }
}

// MARK: State restoration

extension SceneDelegate {
    // Activity type for restoring this scene (loaded from the plist).
    static let MainSceneActivityType = { () -> String in
        // Load the activity type from the Info.plist.
        let activityTypes = Bundle.main.infoDictionary?["NSUserActivityTypes"] as? [String]
        print("MAIN SCENE ACTIVITY TYPE - \(activityTypes![0])")
        return activityTypes![0]
    }
    
    static let presentedChildViewKey = "presentedChildViewKey"
    
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        // Offer the user activity for this scene.
        print("func stateRestorationActivity")
        print(scene.userActivity?.userInfo)
        if  let rootViewController = window?.rootViewController as? UINavigationController,
            let childViewController = rootViewController.topViewController as? ChildViewController {
                childViewController.updateUserActivity()
        }
        return scene.userActivity
    }
}
