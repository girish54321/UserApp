//
//  LoginResponse.swift
//  UserApp
//
//  Created by Girish Parate on 22/09/22.
//

import Foundation
struct LoginScuccess: Codable {
    let token: String?
}

struct LoginFail: Codable {
    let error: String?
}

struct APIError {
    let code: Int
    let message: String
}

struct UserListAPIResponseData {
    let users: [String]
    /// This is a list of users, we might have pagination information, thus struct comes in handy in holding that information
}

enum UserListAPIResponse {
    case Success(UserListAPIResponseData)
    case Fail(APIError) /// Error code, Error message
}


// MARK: - Welcome
struct Welcome: Identifiable, Codable {
    let id = UUID()
    let type: String
    let value: [Value]
}

// MARK: - Value
struct Value: Identifiable, Codable {
    let id: Int
    let joke: String
    let categories: [String]
}


struct CommentModel: Codable, Identifiable {
    let postID, id: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
