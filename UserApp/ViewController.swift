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
        let isLogedIn = AppStorage().isLogedIn()
        var vc: UIViewController = LoginViewController()
        if(isLogedIn == true){
            vc = WelcomeViewController()
        }
        NavigationHelper().createNewRootNavigation(vc: self,
                                                   rootVC: vc,
                                                   style: .fullScreen,
                                                   prefersLargeTitles: true)
    }
    
}

