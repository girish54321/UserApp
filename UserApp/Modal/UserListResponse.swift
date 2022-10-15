//
//  UserListResponse.swift
//  UserApp
//
//  Created by Girish Parate on 08/10/22.
//

import Foundation
// MARK: - UserListResponse
struct UserListResponse: Codable {
    var page, perPage, total, totalPages: Int?
    var data: [UserListData]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct UserListData: Codable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String?
    let text: String?
}
