//
//  AppStorge.swift
//  UserApp
//
//  Created by Girish Parate on 02/10/22.
//

import Foundation

struct AppStorage {
    let storage = UserDefaults.standard
    
    func saveUserState(email: String, tokan: String){
        storage.set(email, forKey: "email")
        storage.set(tokan, forKey: "tokan")
        print("Data Saved")
    }
    
    func logoutUser(){
        storage.removeObject(forKey: "email")
        storage.removeObject(forKey: "tokan")
        print("data Removed")
    }
    
    func isLogedIn() -> Bool {
        if(storage.string(forKey: "tokan") != nil){
            return true
        } else {
            return false
        }
    }
    
}
