//
//  Comment+CoreDataProperties.swift
//  ToDo_CoreData
//
//  Created by Fusion Tech on 22.07.2024.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var name: String?
    @NSManaged public var todo: ToDo?

}

extension Comment : Identifiable {

}
