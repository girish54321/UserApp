//
//  JokeService.swift
//  UserApp
//
//  Created by Girish Parate on 22/09/22.
//

import Foundation
import Alamofire

class AuthService {
    
    func userLogin (
        parameters: Parameters?,
        completion: @escaping(Result<LoginScuccess, NetworkError>) -> Void) {
            return RestAPIClient.request(type: LoginScuccess.self,
                                         endPoint: AuthApiEndpoint().createEndPoint(endPoint: .login),
                                         method:.post,
                                         parameters: parameters,
                                         completion: completion
            )
        }
}


