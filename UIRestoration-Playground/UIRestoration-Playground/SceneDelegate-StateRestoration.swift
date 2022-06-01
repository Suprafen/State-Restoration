//
//  SceneDelegate-StateRestoration.swift
//  UIRestoration-Playground
//
//  Created by Ivan Pryhara on 1.06.22.
//

import UIKit

// MARK: State restoration

extension SceneDelegate {
    // Activity type for restoring this scene (loaded from the plist).
    static let MainSceneActivityType = { () -> String in
        // Load the activity type from the Info.plist.
        let activityTypes = Bundle.main.infoDictionary?["NSUserActivityTypes"] as? [String]
        return activityTypes![0]
    }
    
    static let presentedChildViewKey = "presentedChildViewKey" // Child view presented key (presented = true)
    
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        // Offer the user activity for this scene.
        if  let rootViewController = window?.rootViewController as? UINavigationController,
            let childViewController = rootViewController.topViewController as? ChildViewController {
                childViewController.updateUserActivity()
        }
        return scene.userActivity
    }
}
