//
//  PostCoreDataExtension.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 18/02/1445 AH.
//

import Foundation
import CoreData

extension PostEntity {
    func convertToPostData() -> PostData {
        var cmts = [CommentModel]()
        let fetchRequest: NSFetchRequest<CommentEntity>
        fetchRequest = CommentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "postId == %@ ",
                                             self.id as NSNumber)
        let context = PersistentStorage.shared.context
        do{
            let commts = try context.fetch(fetchRequest)
            for commnt in commts{
                let loadComment = commnt as! CommentEntity
                cmts.append(CommentModel(postID: Int(loadComment.postId ), id: Int(loadComment.id ), name: loadComment.name ?? "", email: loadComment.email ?? "", body:loadComment.body ?? ""))
            }
           
        }
        catch{
            
        }
       
        
        
        
       
        let postData = PostData(_postModel: PostModel(userId: Int(self.userId), title: self.title ?? "", id: Int(self.id), body: self.body ?? ""), _comments: cmts)
        
        
      
        return postData
    }
}
