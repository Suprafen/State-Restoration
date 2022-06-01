//
//  ViewController.swift
//  UIRestoration-Playground
//
//  Created by Ivan Pryhara on 28.05.22.
//

import UIKit

class ViewController: UIViewController, UIViewControllerRestoration {
    let moveForwardButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Move"
        configuration.buttonSize = .large
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(moveForwardButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var label: UILabel!
    var count: Int = 0
    var timer: Timer?

    static func viewController(withRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        print("ViewController withRestorationIdentifierPath")

        return ViewController()
    }

    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        print("ViewController init")

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        restorationIdentifier = "ViewController"
        restorationClass = ViewController.self
    }

    required init?(coder: NSCoder) {
        print("ViewController init(coder)")

        super.init(coder: coder)
    }

    override func viewDidLoad() {
        print("ViewController viewDidLoad")

        super.viewDidLoad()

        view.backgroundColor = .green // be sure this vc is visible

        label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(count)"
        view.addSubview(label)
        view.addSubview(moveForwardButton)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            moveForwardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moveForwardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        print("ViewController viewWillAppear")

        super.viewWillAppear(animated)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.count += 1
            self.label.text = "\(self.count)"
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        //Restoration and present child view controller
        if let activityUserInfo = view.window?.windowScene?.userActivity?.userInfo {
            if activityUserInfo[SceneDelegate.presentedChildViewKey] != nil {
                // Restore the child view controller
                
                let childViewController = ChildViewController()
                
                navigationController?.pushViewController(childViewController, animated: false)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("ViewController viewDidDisappear")

        super.viewDidDisappear(animated)

        timer?.invalidate()
        timer = nil
    }
    
    // MARK: Selectors
    @objc func moveForwardButtonTapped() {
        let viewToShow = ChildViewController()
        
        navigationController?.pushViewController(viewToShow, animated: true)
    }
}

