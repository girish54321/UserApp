//
//  AuthApiEndpoint.swift
//  UserApp
//
//  Created by Girish Parate on 01/10/22.
//

import Foundation

class AuthApiEndpoint {
    
    enum AuthApiType {
        case login
        case register
    }
    
    func createEndPoint(endPoint: AuthApiType) -> String {
        switch endPoint {
        case .login:
            return createApi(endPoint: "/login")
        case .register:
            return createApi(endPoint: "/register")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return "https://reqres.in/api" + endPoint
    }
}
