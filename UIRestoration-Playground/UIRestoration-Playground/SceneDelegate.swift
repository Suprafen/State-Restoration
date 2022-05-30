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
        window = UIWindow(windowScene: winScene)

        let vc = ViewController()

        if let activity = connectionOptions.userActivities.first ?? session.stateRestorationActivity {
            vc.continueFrom(activity: activity)
        }

        let nc = UINavigationController(rootViewController: vc)
        nc.restorationIdentifier = "RootNC"

        self.window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        print("SceneDelegate stateRestorationActivity")

        if let nc = self.window?.rootViewController as? UINavigationController, let vc = nc.viewControllers.first as? ViewController {
            return vc.continuationActivity
        } else {
            return nil
        }
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

