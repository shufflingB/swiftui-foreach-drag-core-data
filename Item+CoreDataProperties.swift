//
//  Item+CoreDataProperties.swift
//  OrderedListBasedOnOrderedRelationship
//
//  Created by Jonathan Hume on 15/07/2020.
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
    @NSManaged public var above: NSOrderedSet?
    @NSManaged public var below: NSOrderedSet?

}

// MARK: Generated accessors for above
extension Item {

    @objc(insertObject:inAboveAtIndex:)
    @NSManaged public func insertIntoAbove(_ value: Item, at idx: Int)

    @objc(removeObjectFromAboveAtIndex:)
    @NSManaged public func removeFromAbove(at idx: Int)

    @objc(insertAbove:atIndexes:)
    @NSManaged public func insertIntoAbove(_ values: [Item], at indexes: NSIndexSet)

    @objc(removeAboveAtIndexes:)
    @NSManaged public func removeFromAbove(at indexes: NSIndexSet)

    @objc(replaceObjectInAboveAtIndex:withObject:)
    @NSManaged public func replaceAbove(at idx: Int, with value: Item)

    @objc(replaceAboveAtIndexes:withAbove:)
    @NSManaged public func replaceAbove(at indexes: NSIndexSet, with values: [Item])

    @objc(addAboveObject:)
    @NSManaged public func addToAbove(_ value: Item)

    @objc(removeAboveObject:)
    @NSManaged public func removeFromAbove(_ value: Item)

    @objc(addAbove:)
    @NSManaged public func addToAbove(_ values: NSOrderedSet)

    @objc(removeAbove:)
    @NSManaged public func removeFromAbove(_ values: NSOrderedSet)

}

// MARK: Generated accessors for below
extension Item {

    @objc(insertObject:inBelowAtIndex:)
    @NSManaged public func insertIntoBelow(_ value: Item, at idx: Int)

    @objc(removeObjectFromBelowAtIndex:)
    @NSManaged public func removeFromBelow(at idx: Int)

    @objc(insertBelow:atIndexes:)
    @NSManaged public func insertIntoBelow(_ values: [Item], at indexes: NSIndexSet)

    @objc(removeBelowAtIndexes:)
    @NSManaged public func removeFromBelow(at indexes: NSIndexSet)

    @objc(replaceObjectInBelowAtIndex:withObject:)
    @NSManaged public func replaceBelow(at idx: Int, with value: Item)

    @objc(replaceBelowAtIndexes:withBelow:)
    @NSManaged public func replaceBelow(at indexes: NSIndexSet, with values: [Item])

    @objc(addBelowObject:)
    @NSManaged public func addToBelow(_ value: Item)

    @objc(removeBelowObject:)
    @NSManaged public func removeFromBelow(_ value: Item)

    @objc(addBelow:)
    @NSManaged public func addToBelow(_ values: NSOrderedSet)

    @objc(removeBelow:)
    @NSManaged public func removeFromBelow(_ values: NSOrderedSet)

}
