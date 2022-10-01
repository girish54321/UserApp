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
        userLoginApt(email: "eve.holt@reqres.in", password: "cityslicka")
    }
    
    @IBAction func onSignUpBtnTap(_ sender: Any) {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func userLoginApt (email: String,password: String) {
        let postData: [String:Any] = [
            "email": email,
            "password": password
        ]
        let okButton = Alert().makeUIAlertButton(title: "Ok", style: .default, actionFunction: {
        })
        AuthService().userLogin(parameters: postData) { result in
            switch result {
            case .success(let data):
                let value = data
                Alert().showNormlaAleat(title: "Token", message: value.token ?? "nil", vc: self, actionsList: [okButton])
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let mess):
                    Alert().showNormlaAleat(title: "Error", message: mess, vc: self, actionsList: [okButton])
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
                print(error)
            }
        }
    }
}


