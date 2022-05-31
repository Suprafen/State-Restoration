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
    
    
    // MARK: Helper methods
    
    func configureView() {
        self.view.backgroundColor = .white
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
