//
//  APIEndpoint.swift
//  UserApp
//
//  Created by Girish Parate on 25/09/22.
//

import Foundation
class AuthApiEndpoint {
    
    enum ApiType {
        case login
    }
    
    func createEndPoint(endPoint: ApiType) -> String {
        switch endPoint {
        case .login:
            return createApi(endPoint: "/login")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return "https://reqres.in/api" + endPoint
    }
}
