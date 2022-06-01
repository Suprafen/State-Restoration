//
//  ChildViewController.swift
//  UIRestoration-Playground
//
//  Created by Ivan Pryhara on 31.05.22.
//

import UIKit

class ChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUserActivity()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let currentUserActivity = view.window?.windowScene?.userActivity {
            // The system is dismissing the scene. Remove user activity-related data.
            currentUserActivity.userInfo?.removeValue(forKey: SceneDelegate.presentedChildViewKey)
        }
    }
    // MARK: Helper methods
    
    func configureView() {
        self.view.backgroundColor = .white
    }

    func updateUserActivity() {
        var currentUserActivity = view.window?.windowScene?.userActivity
        
        if currentUserActivity == nil {
            currentUserActivity = NSUserActivity(activityType: SceneDelegate.MainSceneActivityType())
        }
        
        currentUserActivity?.addUserInfoEntries(from: [SceneDelegate.presentedChildViewKey: true])
        
        currentUserActivity?.userInfo = ["ViewIdentifier":"Child1"]
        view.window?.windowScene?.userActivity = currentUserActivity
        print(view.window?.windowScene?.userActivity?.userInfo)
    }
}
