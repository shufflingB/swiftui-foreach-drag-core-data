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
    //  How to find the Root Item for everything else.
    static let rootItemPredicate = NSPredicate(format: "root == YES")
    
}
