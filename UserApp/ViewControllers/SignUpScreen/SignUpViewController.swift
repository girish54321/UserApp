//
//  SignUpViewController.swift
//  UserApp
//
//  Created by Girish Parate on 22/09/22.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onClickSignUp(_ sender: Any) {
        createAccount()
    }
    
    func createAccount(){
        let postData : [String: Any] = [
            "email": emailText.text!,
            "password": passwordText.text!
        ]
        
        let okButton = Alert().makeUIAlertButton(title: "Ok", style: .default, actionFunction: {
            print("Ok Tap")
        })
        
        AuthServices().createAccount(parameters: postData){
            result in
            switch result {
            case .success(let data):
                let vc = WelcomeViewController()
                NavigationHelper().createNewRootNavigation(vc: self, rootVC: vc, style: .fullScreen, prefersLargeTitles: true)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("Error Message")
                    print(errorMessage)
                    Alert().showNormlaAleat(title: "Error", message: errorMessage, vc: self, actionsList: [okButton])
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
            }
        }
        
    }
}
