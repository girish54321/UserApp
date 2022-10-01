//
//  UIHelper.swift
//  UserApp
//
//  Created by Girish Parate on 01/10/22.
//

import Foundation
import UIKit

struct Alert {
    func showBootmSheet(title: String, message: String,vc: UIViewController,actionsList: [UIAlertAction]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for actions in actionsList {
            alertController.addAction(actions)
        }
        
        let cancelButton = makeUIAlertButton(title: "Cancel", style: UIAlertAction.Style.destructive, actionFunction: {
            print("Cancel taped")
        })
        
        alertController.addAction(cancelButton)
        DispatchQueue.main.async { vc.present(alertController, animated: true) }
    }
    
    func showNormlaAleat(title: String, message: String,vc: UIViewController,actionsList: [UIAlertAction]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for actions in actionsList {
            alertController.addAction(actions)
        }
        DispatchQueue.main.async { vc.present(alertController, animated: true) }
    }
    
    func makeUIAlertButton(title: String, style:UIAlertAction.Style ,actionFunction: @escaping () -> Void) -> UIAlertAction {
        let actionButton = UIAlertAction(title: title, style: style, handler: {(action: UIAlertAction!) in actionFunction()})
        return actionButton
    }
}

struct Helper {
    
    func createQueryParams(baseUrl: String,queryItems: [URLQueryItem]) -> URL {
        var urlComps = URLComponents(string:baseUrl)
        urlComps?.queryItems = queryItems
        return (urlComps?.url!)!
    }
}

extension URL {
    func valueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}



