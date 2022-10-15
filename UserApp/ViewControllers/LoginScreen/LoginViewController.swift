//
//  LoginViewController.swift
//  UserApp
//
//  Created by Girish Parate on 22/09/22.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onLoginBtnTap(_ sender: Any) {
        userLoginApt()
    }
    
    @IBAction func onSignUpBtnTap(_ sender: Any) {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func userLoginApt(){
        let postData : [String: Any] = [
//            "email": emailText.text!,
//            "password": passwordText.text!
            "email": "eve.holt@reqres.in",
            "password": "cityslicka"
        ]
        
        let okButton = Alert().makeUIAlertButton(title: "ok", style: .default, actionFunction: {
            print("ok taped")
        })
        
        AuthServices().userLogin(parameters: postData){
            result in
            switch result {
            case .success(let data):
                AppStorage().saveUserState(email: self.emailText.text!, tokan: data.token!)
                let vc = WelcomeViewController()
                NavigationHelper().createNewRootNavigation(vc: self, rootVC: vc, style: .fullScreen, prefersLargeTitles: true)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    Alert().showNormlaAleat(title: "Error", message: errorMessage, vc: self, actionsList:[okButton] )
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


