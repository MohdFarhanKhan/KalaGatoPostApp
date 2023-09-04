//
//  PostEntity+CoreDataProperties.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 18/02/1445 AH.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var userId: Int32
    @NSManaged public var comments: [CommentEntity]?
   
}

// MARK: Generated accessors for comments
extension PostEntity {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: CommentEntity)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: CommentEntity)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: [CommentEntity])

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: [CommentEntity])

}

extension PostEntity : Identifiable {

}
