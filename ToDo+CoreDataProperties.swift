//
//  ToDo+CoreDataProperties.swift
//  ToDo_CoreData
//
//  Created by Fusion Tech on 22.07.2024.
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var date: Date
    @NSManaged public var details: String
    @NSManaged public var name: String
    @NSManaged public var priority: Int16
    @NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for comments
extension ToDo {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

extension ToDo : Identifiable {

}
