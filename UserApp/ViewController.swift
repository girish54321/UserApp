//
//  ViewController.swift
//  UserApp
//
//  Created by Girish Parate on 22/09/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.showRootVC()
        }
    }

    func showRootVC () {
        let vc = LoginViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.navigationBar.prefersLargeTitles = true
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }

}

