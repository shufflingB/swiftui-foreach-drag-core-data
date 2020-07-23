//
//  Item+CoreDataProperties.swift
//  OrderedListBasedOnOrderedRelationship
//
//  Created by Jonathan Hume on 22/07/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var root: Bool
    @NSManaged public var parentsList: NSOrderedSet?
    @NSManaged public var childrenList: NSOrderedSet?
    
    
    

}

// MARK: Generated accessors for parentsList
extension Item {

    @objc(insertObject:inParentsListAtIndex:)
    @NSManaged public func insertIntoParentsList(_ value: Item, at idx: Int)

    @objc(removeObjectFromParentsListAtIndex:)
    @NSManaged public func removeFromParentsList(at idx: Int)

    @objc(insertParentsList:atIndexes:)
    @NSManaged public func insertIntoParentsList(_ values: [Item], at indexes: NSIndexSet)

    @objc(removeParentsListAtIndexes:)
    @NSManaged public func removeFromParentsList(at indexes: NSIndexSet)

    @objc(replaceObjectInParentsListAtIndex:withObject:)
    @NSManaged public func replaceParentsList(at idx: Int, with value: Item)

    @objc(replaceParentsListAtIndexes:withParentsList:)
    @NSManaged public func replaceParentsList(at indexes: NSIndexSet, with values: [Item])

    @objc(addParentsListObject:)
    @NSManaged public func addToParentsList(_ value: Item)

    @objc(removeParentsListObject:)
    @NSManaged public func removeFromParentsList(_ value: Item)

    @objc(addParentsList:)
    @NSManaged public func addToParentsList(_ values: NSOrderedSet)

    @objc(removeParentsList:)
    @NSManaged public func removeFromParentsList(_ values: NSOrderedSet)

}

// MARK: Generated accessors for childrenList
extension Item {

    @objc(insertObject:inChildrenListAtIndex:)
    @NSManaged public func insertIntoChildrenList(_ value: Item, at idx: Int)

    @objc(removeObjectFromChildrenListAtIndex:)
    @NSManaged public func removeFromChildrenList(at idx: Int)

    @objc(insertChildrenList:atIndexes:)
    @NSManaged public func insertIntoChildrenList(_ values: [Item], at indexes: NSIndexSet)

    @objc(removeChildrenListAtIndexes:)
    @NSManaged public func removeFromChildrenList(at indexes: NSIndexSet)

    @objc(replaceObjectInChildrenListAtIndex:withObject:)
    @NSManaged public func replaceChildrenList(at idx: Int, with value: Item)

    @objc(replaceChildrenListAtIndexes:withChildrenList:)
    @NSManaged public func replaceChildrenList(at indexes: NSIndexSet, with values: [Item])

    @objc(addChildrenListObject:)
    @NSManaged public func addToChildrenList(_ value: Item)

    @objc(removeChildrenListObject:)
    @NSManaged public func removeFromChildrenList(_ value: Item)

    @objc(addChildrenList:)
    @NSManaged public func addToChildrenList(_ values: NSOrderedSet)

    @objc(removeChildrenList:)
    @NSManaged public func removeFromChildrenList(_ values: NSOrderedSet)

}
