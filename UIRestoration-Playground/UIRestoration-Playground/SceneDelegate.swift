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
            /**
                 Use userInfo for recreating UI. Depends on value that's stored in userInfo you can
                 call different viewControllers or tabs in TabBarController
            */
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
