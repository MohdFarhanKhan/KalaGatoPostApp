//
//  LikePostEntity+CoreDataProperties.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 18/02/1445 AH.
//
//

import Foundation
import CoreData


extension LikePostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikePostEntity> {
        return NSFetchRequest<LikePostEntity>(entityName: "LikePostEntity")
    }

    @NSManaged public var id: Int32

}

extension LikePostEntity : Identifiable {

}
