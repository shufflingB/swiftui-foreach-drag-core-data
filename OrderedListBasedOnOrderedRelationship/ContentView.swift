//
//  ContentView.swift
//  OrderedListBasedOnDecimals
//
//  Created by Jonathan Hume on 08/07/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import CoreData
import os.log
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: Item.rootItemPredicate) var possibleRootItems: FetchedResults<Item>
    @FetchRequest(sortDescriptors: []) var allItems: FetchedResults<Item>

    var rootItem: Item? {
        switch possibleRootItems.count {
        case 1:
            //                os_log("Using existing root item", type: .debug)
            return possibleRootItems[0]
        case ...0, nil:
            os_log("No root Items detected", type: .debug)
            return nil
        default:
            os_log("Unexpected number of Root Items found (%d) in CoreData store. Using the first one but should only be one", type: .fault, possibleRootItems.count)
            return possibleRootItems[0]
        }
    }

    func onAppearRootItemCreateIfNecessary() {
        // Setup the Core Data structure.
        // NB: This cannot be done implicitly via the derived rootItem property as that triggers the rootItem derived state variable
        // to change value during rendering which is bad bad karma (tm)
        if possibleRootItems.count == 0 {
            os_log("Creating new Root Item", type: .debug)
            // Instantiate a root item
            let rootItem = Item(context: moc)
            rootItem.id = UUID()
            rootItem.title = "ROOT ITEM"
            rootItem.root = true
            saveChanges()
        }
    }

    func createNewItemBelowRoot() {
        guard let safeRootItem = rootItem else {
            os_log("Failed attempt to create a new child Item for an undefined Root", type: .fault)
            return
        }
        os_log("Creating new Item below Root", type: .debug)
        createNewItem(childOf: safeRootItem)
    }

    func createNewItem(childOf parentItem: Item) {
        let childItem = Item(context: moc)
        childItem.id = UUID()
        childItem.title = "Item number \(Date())"
        parentItem.addToChildrenList(childItem)
    }

    func deleteChildItems(_ indices: IndexSet) {
        guard let safeRootItem = rootItem else {
            os_log("Failed attempt to delete child Items from an undefined Root", type: .fault)
            return
        }

        guard let safechildren = safeRootItem.childrenList else {
            os_log("Failed attempt to delete child Items from a Root that has no children", type: .fault)
            return
        }

        os_log("Removing %d items ", type: .debug, indices.count)
        let setToRemove: NSOrderedSet = NSOrderedSet(array: safechildren.objects(at: indices))
        _ = setToRemove.map({ item in moc.delete(item as! NSManagedObject) })
    }

    func rearrangeChildItemsWorking(srcIndices: IndexSet, tgtArraySpecOffsetIdx: Int) {
        guard let firstMovedIdx = srcIndices.first else {
            os_log("Failed attempt to rearrange child Items received empty set of indices to move", type: .fault)
            return
        }

        guard firstMovedIdx != tgtArraySpecOffsetIdx else {
            // os_log("Not rearranging children as source and tgt idx the same", type: .debug)
            return
        }

        guard let safeRootItem = rootItem else {
            os_log("Failed attempt to rearrange child Items for an undefined Root", type: .fault)
            return
        }

        guard let safeChildrenList = safeRootItem.childrenList else {
            os_log("Failed attempt to rearrange child Items, Root has no children", type: .fault)
            return
        }

        /*
         Convert tgt offsetIdx from one intended for use with Arrays to one suitable for MutableOrderedSets.

         Why?
         ===
         Foreach's onMove calls with an offset which I believe has been optimised for use with what Swift 5.X
         standard library Array's move method takes as input. Namely we get an offset to whence objects are to be
         moved to that is slightly tricksy in that it is specified as being as if the original elements are
         not removed first before copy, i.e.conceptually the tgt output is formed by 1) Clone moved elements
         to new location. 2) Remove the elements that have been cloned.

         This optimisations means that when dragging up to a lower index this makes no difference -  as the original
         elements are below. However, when dragging down the tgt idx received from ForEach will be the
         "end location idx + num the elements left behind on the copy/move". e.g. for the array ['a', 'b', 'c']
         moving 'a' to after 'c''s location would us an IndexSet that contained 0 and a offset idx of 3 (and not 2)

         Now, when the NSMutableArrayOrdered moveObjects method is used here for the move, this expects the tgt offset
         idx to just be specified as is required in the final output, i.e. conceptually it's formed by 1) Remove the
         original elements. 2) Re-insert them at the new location.

         Therefore we need convert the Array move offset into one suitable MutableOrderedSets by removing the 'extra' offset
         when the rows are dragged down.
         */

        let draggedUp = firstMovedIdx > tgtArraySpecOffsetIdx ? true : false
        let tgtMutableOrderedSetOffsetIdx = draggedUp ? tgtArraySpecOffsetIdx : tgtArraySpecOffsetIdx - srcIndices.count

        /* The dang child and parent relationships should a mutable NSMutableOrderedSet according to official docs
         but they are not (the Editor> Create NSManagedObject codegen only creates an NSOrderedSet for them). So as a
         workaround we have to create a mutable copy, update it and then blat the original.

         Example of how it should look in `rearrangeChildItemsCodegenBreaks`
         */
        let updatedList: NSMutableOrderedSet = NSMutableOrderedSet(orderedSet: safeChildrenList)

        updatedList.moveObjects(at: srcIndices, to: tgtMutableOrderedSetOffsetIdx)

        safeRootItem.childrenList = updatedList
    }

    /*
     // This doesn't work because the codegen only provides NSOrderedSet and not NSMutableOrderedSet. Which
     // which means that at runtime it appears to work, but then silently fails to update the Core Data backend :-(

     func rearrangeChildItemsCodegenBreaks(movedItemIndices: IndexSet, offsetIdx: Int) {
         guard let safeRootItem = rootItem else {
             os_log("Failed attempt to rearrange child Items for an undefined Root", type: .fault)
             return
         }
         guard let firstMovedIdx = movedItemIndices.first  else {
             os_log("Failed attempt to rearrange child Items received empty set of indices to move", type: .fault)
             return
         }
         guard let safeChildrenList = safeRootItem.childrenList  else {
             os_log("Failed attempt to rearrange child Items, Root has no children", type: .fault)
             return
         }

         let draggedUp = firstMovedIdx > offsetIdx ? true : false
         let finalDestIdx = draggedUp ? offsetIdx : offsetIdx - 1

         print("First mv idx = \(firstMovedIdx), input tgt idx = \(offsetIdx), Dragged up = \(draggedUp), finalDestIdx = \(finalDestIdx)")

         (safeChildrenList as! NSMutableOrderedSet).moveObjects(at: movedItemIndices, to: finalDestIdx) // <= NB: Silently fails

     }
     */

    func saveChanges() {
        do {
            if moc.hasChanges {
                try moc.save()
                os_log("Saved Core Data changes", type: .debug)
            }
        } catch {
            os_log("%s", type: .fault, error.localizedDescription)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Root items = \(possibleRootItems.count), All Items = \(allItems.count)")
                rootItem == nil ? AnyView(Text("App oopsy, no root Item defined"))
                    : AnyView(
                        List {
                            ForEach(rootItem!.childrenList!.array as! [Item], id: \.self) { item in
                                Text("Item UUID = \(String(item.id?.uuidString.suffix(8) ?? "No id defined"))")
                            }
                            .onDelete(perform: deleteChildItems)
                            .onMove(perform: rearrangeChildItemsWorking)
                        }
                    )

                Button(action: createNewItemBelowRoot) {
                    Text("Add an item")
                        .padding()
                }

                Button(action: saveChanges) {
                    Text("Save Changes?")
                        .padding()
                }
            }
            .navigationBarItems(leading: EditButton())
            .onAppear(perform: onAppearRootItemCreateIfNecessary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
