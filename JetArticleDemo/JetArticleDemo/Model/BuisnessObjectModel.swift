//
//  BuisnessObjectModel.swift
//  JetArticleDemo
//
//  Created by Dipak Dhondge on 03/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import Foundation
struct Article: Codable {
    var id: String
    var content: String
    var comments: Int
    var likes: Int
    var createdAt: String
    var media: [Media]
    var user: [User]

}

struct Media: Codable {
    var id: String
    var blogId: String
    var image: String
    var url: String
    var title: String
}

struct User: Codable {
    var id: String
    var blogId: String
    var name: String
    var avatar: String
    var lastname: String
    var city: String
    var designation: String
    var about: String


}

extension Article{
   enum CodingKeys: String, CodingKey {
    
    case id
    case content
    case comments
    case likes
    case createdAt
    case media
    case user
   }
}

extension Media{
   enum CodingKeys: String, CodingKey {
    
        case id
        case blogId
        case image
        case url
        case title

   }
}

extension User{
   enum CodingKeys: String, CodingKey {
    
        case id
        case blogId
        case name
        case avatar
        case lastname
        case city
        case designation
        case about

   }
}
