//
//  CommentEntity+CoreDataProperties.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 18/02/1445 AH.
//
//

import Foundation
import CoreData


extension CommentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CommentEntity> {
        return NSFetchRequest<CommentEntity>(entityName: "CommentEntity")
    }

    @NSManaged public var body: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var postId: Int32
    @NSManaged public var post: PostEntity?

}

extension CommentEntity : Identifiable {

}
