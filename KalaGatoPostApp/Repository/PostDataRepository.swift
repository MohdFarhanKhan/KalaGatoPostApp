//
//  PostDataRepository.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 17/02/1445 AH.
//

import Foundation

import CoreData

struct PostDataRepository {
    //CommentEntity
    func deleteDataFromEntityTable(){
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CommentEntity")

        // Create Batch Delete Request
      
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
       
        do {
            try  PersistentStorage.shared.context.execute(batchDeleteRequest)

        } catch {
            // Error Handling
        }
    }
    func deleteDataFromPostTable(){
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostEntity")

        // Create Batch Delete Request
      
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
       
        do {
            try  PersistentStorage.shared.context.execute(batchDeleteRequest)

        } catch {
            // Error Handling
        }
    }
    func deleteDataFromCommentTable(){
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostEntity")

        // Create Batch Delete Request
      
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
       
        do {
            try  PersistentStorage.shared.context.execute(batchDeleteRequest)

        } catch {
            // Error Handling
        }
    }
    func isFavorite(postId: Int, completionHandler:@escaping(_ result: Bool)-> Void){
        let fetchRequest: NSFetchRequest<LikePostEntity>
        fetchRequest = LikePostEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@ ",
                                             postId as NSNumber)
        let context = PersistentStorage.shared.context
        do{
            let likeFavorite = try context.fetch(fetchRequest)
            if likeFavorite.count >= 1{
                completionHandler(true)
            }
            else{
                completionHandler(false)
            }
           
        }
        catch{
            completionHandler(false)
        }
       
    }
    func saveToFavorite(postId: Int, completionHandler:@escaping(_ result: String)-> Void){
        
        isFavorite(postId: postId) { result in
            if result == true{
                completionHandler("\(postId) is already favorite")
            }
            else{
                var favoriteCoreData = LikePostEntity(context: PersistentStorage.shared.context)
                favoriteCoreData.id = Int32(postId)
                do{
                   try PersistentStorage.shared.context.save()
                    completionHandler("Successfully saved to favorite")
                }
                catch{
                    completionHandler("Error during saving to favorite")
                }
                
            }
        }
    }
    func getPostEntityCoreData(postId:Int,  completionHandler:@escaping(_ result: Array<PostEntity>?)-> Void){
        let fetchRequest: NSFetchRequest<PostEntity>
        fetchRequest = PostEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@ ",
                                             postId as NSNumber)
        let context = PersistentStorage.shared.context
        do{
            let likeFavorite = try context.fetch(fetchRequest)
            if likeFavorite.count >= 1{
                completionHandler(likeFavorite)
            }
            else{
                completionHandler(nil)
            }
           
        }
        catch{
            completionHandler(nil)
        }
    }
    func getFavorite( completionHandler:@escaping(_ result: Array<PostData>?)-> Void){
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: LikePostEntity.self)
            var postRecords : Array<PostData> = []
        if result != nil && result!.count >= 1{
            result?.forEach({ (favoriteCoreDataRecord) in
                getPostEntityCoreData(postId: Int(favoriteCoreDataRecord.id)) { resultPostCoreData in
                    if resultPostCoreData != nil && resultPostCoreData!.count >= 1{
                        resultPostCoreData?.forEach({ (postCoreDataRecord) in
                            postRecords.append(postCoreDataRecord.convertToPostData())
                            
                            if result?.last?.id == favoriteCoreDataRecord.id{
                                completionHandler(postRecords)
                            }
                        })
                    }
                }
                
                
                
            })
        }
        else{
            completionHandler(nil)
        }
          
        
    }
    func batchInsertPostRecords(records: Array<PostData>, completionHandler:@escaping(_ result:Bool)-> Void){

        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in

            // batch inserts
            let request = self.createBatchInsertRequest(records: records,mnObjectcontext: privateManagedContext )
            do{
                try privateManagedContext.execute(request)
                try privateManagedContext.save()
                
                completionHandler(true)
            }catch {
                completionHandler(false)
                debugPrint("batch insert error")
            }
        }

        

    }

    private func createBatchInsertRequest(records:Array<PostData>, mnObjectcontext:NSManagedObjectContext) -> NSBatchInsertRequest {

        let totalCount = records.count
        var index = 0

        let batchInsert = NSBatchInsertRequest(entity: PostEntity.entity()) { (managedObject: NSManagedObject) -> Bool in

            guard index < totalCount else {return true}

            if let postCoreData = managedObject as? PostEntity {
                let data = records[index]
                postCoreData.id = Int32(data.postData.id)
                postCoreData.userId = Int32(data.postData.userId)
                postCoreData.title = data.postData.title
                postCoreData.body = data.postData.body
                if let cmts = data.comments{
                    var commentArray = [CommentEntity]()
                    for cmt in cmts{
                        var commentCoreData = CommentEntity(context: mnObjectcontext)
                        commentCoreData.id = Int32(cmt.id)
                        commentCoreData.body = cmt.body
                        commentCoreData.email = cmt.email
                        commentCoreData.name = cmt.name
                        commentCoreData.postId = Int32(cmt.postID)
                        postCoreData.addToComments(commentCoreData)
                        //commentArray.append(commentCoreData)
                       
                       
                    }
                    
                   
                    if commentArray.count > 0{
                       let newSet =  NSSet(array: commentArray)
                       // postCoreData.comments = newSet
                       
                    }
                }
                
            }

            index  += 1
            return false
        }

        return batchInsert

    }

  



    func getPostCoreDataRecords(completionHandler: @escaping (Array<PostData>?) -> Void) {
       
           debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
       
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: PostEntity.self)
            var postRecords : Array<PostData> = []
            result?.forEach({ (postCoreDataRecord) in
                postRecords.append(postCoreDataRecord.convertToPostData())
                
              
            })

            completionHandler(postRecords)

    }
}
