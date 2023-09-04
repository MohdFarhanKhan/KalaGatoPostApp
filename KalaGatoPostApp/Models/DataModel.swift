//
//  PostModel.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 17/02/1445 AH.
//

import Foundation

struct PostResponse 
{
    let errorMessage: String?
    let postData: [PostModel]?
}
class PostData:Codable
{
    var postData:PostModel
    var comments: [CommentModel]?

    init(_postModel:PostModel, _comments: [CommentModel]? = nil)
    {
        self.postData = _postModel
       
        self.comments = _comments
    }
}

class PostModel: Codable {
    
    var userId: Int
    var title: String
    var id: Int
    var body: String
    init(userId: Int, title: String, id: Int, body: String) {
        self.userId = userId
        self.title = title
        self.id = id
        self.body = body
    }
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case title = "title"
        case id = "id"
        case body = "body"
         
    }
}

class CommentModel: Codable {
    
    var postID: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    init(postID: Int, id: Int, name: String, email: String, body: String) {
        self.postID = postID
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id = "id"
        case name = "name"
        case email = "email"
        case body = "body"
         
    }
}


