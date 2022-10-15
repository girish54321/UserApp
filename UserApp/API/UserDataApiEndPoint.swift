//
//  UserDataApiEndPoint.swift
//  UserApp
//
//  Created by Girish Parate on 08/10/22.
//

import Foundation
class UserDataApiEndPoint {
    
    enum UserDataApiType {
        case userList
    }
    
    func createEndPoint(endPoint: UserDataApiType) -> String {
        switch endPoint {
        case .userList:
            return createApi(endPoint: "/users") //https://reqres.in/api/users?page=2
        }
    }
    
    func createApi(endPoint: String) -> String {
        return "https://reqres.in/api" + endPoint
    }
}
