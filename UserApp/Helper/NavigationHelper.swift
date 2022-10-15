//
//  NavigationHelper.swift
//  UserApp
//
//  Created by Girish Parate on 01/10/22.
//

import Foundation
import UIKit

struct NavigationHelper {
    
    func createNewRootNavigation(vc: UIViewController, rootVC: UIViewController,
                                 style: UIModalPresentationStyle,prefersLargeTitles: Bool ){
        
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.navigationBar.prefersLargeTitles = true
        navVC.modalPresentationStyle = .fullScreen
        vc.present(navVC, animated: true)
    }
    
    func goToScreen(vc: UIViewController,goToVC: UIViewController){
        vc.navigationController?.pushViewController(goToVC, animated: true)
    }
    
}
