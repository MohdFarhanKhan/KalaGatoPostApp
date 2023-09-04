//
//  PostViewModel.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 17/02/1445 AH.
//

import Foundation

struct PostViewModel {

    private let _postDataRepository : PostDataRepository = PostDataRepository()
   
    func savrAsFavorite(postId: Int, completionHandler:@escaping(_ result: String)-> Void){
        _postDataRepository.saveToFavorite(postId: postId) { result in
            completionHandler(result)
        }
    }
    func isFavoriteData(postId: Int, completionHandler:@escaping(_ result: Bool)-> Void) {
        _postDataRepository.isFavorite(postId: postId) { result in
            completionHandler(result)
        }
    }
    func getFavoriteData(completionHandler:@escaping(_ result: Array<PostData>?)-> Void) {
        _postDataRepository.getFavorite { result in
            completionHandler(result)
        }
    }
    func refetchData(completionHandler:@escaping(_ result: String)-> Void){
        if NetworkReachability.shared.isConnected{
            _postDataRepository.deleteDataFromEntityTable()
            _postDataRepository.deleteDataFromPostTable()
            self.getData { result in
                if result == nil || result?.isEmpty == true{
                    completionHandler("Data could not fetched ")
                }
                else{
                    completionHandler("Data fetched successfully ")
                }
            }
        }
        else{
            completionHandler("Due to not connected internet, data could not fetched ")
        }
    }
    func getData(completionHandler:@escaping(_ result: Array<PostData>?)-> Void) {

        _postDataRepository.getPostCoreDataRecords() { response in
            if(response != nil && response?.count != 0){
                // return response to the view controller
                completionHandler(response)

            }else {
                // call the api
               
                var arrayPostData = [PostData]()
               
                HttpUtility.shared.getApiData(requestUrl: URL(string: "https://jsonplaceholder.typicode.com/posts")!, resultType: [PostModel].self) { result in
                    if(result != nil && result?.count != 0){
                      
                        for postRecord in result!{
                          
                            HttpUtility.shared.getApiData(requestUrl: URL(string: "https://jsonplaceholder.typicode.com/posts/\(postRecord.id)/comments")!, resultType: [CommentModel].self) { comments in
                                if(comments != nil && comments?.count != 0){
                                   
                                    arrayPostData.append(PostData(_postModel: postRecord,_comments: comments))
                                }
                                else{
                                  
                                    arrayPostData.append(PostData(_postModel: postRecord))
                                }
                                if postRecord.id == result!.last?.id{
                                    _postDataRepository.batchInsertPostRecords(records: arrayPostData) { result in
                                        completionHandler(arrayPostData)
                                    }
                                  
                                      
                                }
                            }
                            
                        }
                       
                     
                    }
                    else{
                        completionHandler(arrayPostData)
                    }
                }
                
            }
        }

    }
}
