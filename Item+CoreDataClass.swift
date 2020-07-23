//
//  Item+CoreDataClass.swift
//  OrderedListBasedOnOrderedRelationship
//
//  Created by Jonathan Hume on 22/07/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//
//

import Foundation
import CoreData


public class Item: NSManagedObject {
//    static let rootItemPredicate = NSPredicate(format: "parentsList.@count == 0")
    static let rootItemPredicate = NSPredicate(format: "root == YES")
    
    
    // Based on the code from https://www.corysullivan.com/2016/05/24/core-data-and-ordered-relationships.html
//    private var mutableSubItems: NSMutableOrderedSet {
//        return mutableOrderedSetValue(forKey: "subItems")
//    }
//
//    public func indexOfObject(item: Item) -> Int {
//        return mutableSubItems.index(of: item)
//    }
//
//    public func insertObject(item: Item, index: Int) {
//        mutableSubItems.insert(Item.self, at: index)
//        //nb orginal mutableSubItems.insertObject(SubItem, atIndex: index)
//    }
//
//    public func moveObjectsFart(item: Item, indexes: NSIndexSet, toIndex: Int) {
//        print("I am being run")
//        mutableSubItems.moveObjects(at: indexes as IndexSet, to: toIndex)
//    }
//
//
//
//    
    
}
