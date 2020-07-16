//
//  ContentView.swift
//  OrderedListBasedOnDecimals
//
//  Created by Jonathan Hume on 08/07/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//


import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    
    //    @FetchRequest(entity: Item.entity(), sortDescriptors: []) var rootItems: FetchedResults<Item>
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "above.@count == 0")
    ) var itemsWithNothingAbove: FetchedResults<Item>
    
    
    var itemRoot: Item? {
        guard itemsWithNothingAbove.isEmpty == false else {
            return nil
        }
        return itemsWithNothingAbove[0]
        
    }
    
    
    
    func setupCoreData () {
        
        if itemsWithNothingAbove.count == 0 {
            let rootItem = Item(context: moc)
            rootItem.title = "ROOT ITEM"
            saveChanges()
        }
    }
    
//    init() {
//        setupCoreData()
//    }
    
    
    //    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(key: sortKey , ascending: true)]) var items: FetchedResults<Item>
    
    //    static let sortKey = "order"
    //    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(key: sortKey , ascending: true)]) var items: FetchedResults<Item>
    
    func createNewItem() {
        
//        let newItem = Item(context: moc)
//
//        newItem.title = "Item number \(Date())"
//        itemRoot.addToBelow(newItem)
//
//        saveChanges()
    }
    
    func deleteItems(_ indices: IndexSet) {
//        itemRoot.removeFromBelow(at: indices as NSIndexSet)
//        saveChanges()
    }
    
    
    
    func saveChanges() {
        do {
            if self.moc.hasChanges {
                try self.moc.save()
            }
        } catch {
            NSLog(error.localizedDescription)
        }
    }
    
    
    
    
    func moveItems(movedItemIndices: IndexSet, tgtIdxOffset: Int) {
        
        //
        //        guard movedItemIndices.count == 1 else {
        //            NSLog("can move one Item, asked to move \(movedItemIndices.count)")
        //            return
        //        }
        //
        //        let movedItemIdx = movedItemIndices.first
        //        let lastValidIdx = items.endIndex - 1  // Oddly, array.endIndex is actually the +1 on from the last valid one :/
        //
        //        // When dragging to the top of the list we get tgt index of 0, in which case we will deal with by setting
        //        // -1 on whatever the order value is currently at the top.
        //        let itemAboveOrder = tgtIdxOffset == 0
        //            ? items[tgtIdxOffset].order - 1.0 : items[tgtIdxOffset-1].order
        //
        //        // When dragging to the end of the list we get tgt index of last value +1, in which case we will deal with by setting
        //        // + whatever the order value currently is at the bottom
        //        let itemBelowOrder = tgtIdxOffset == lastValidIdx + 1
        //            ? items[lastValidIdx].order + 1.0 : items[tgtIdxOffset].order
        //
        //
        //        let newItemOrder = itemAboveOrder + (itemBelowOrder - itemAboveOrder) / 2.0
        //        //        print("movedItemIdx \(movedItemIdx ?? -99999), tgtIdxOffset \(tgtIdxOffset), lastValidIdx \(lastValidIdx), itemBelowOrder, \(itemBelowOrder), itemAboveOrder \(itemAboveOrder), newItemOrder \(newItemOrder)")
        //
        //        items[movedItemIdx!].order = newItemOrder
        
        
    }
    
    
    
    
    
    
    var body: some View {
        
        
        NavigationView {
            VStack {
                Text("Number of root items = \(itemsWithNothingAbove.count)")
                
                
                itemRoot == nil ? AnyView(Text("No items")) :
                    
                    AnyView(List {
                        
                        ForEach(itemRoot!.below!.array as! [Item], id: \.self) { item in
                            Text("Title \(item.title ?? "No title")")
                        }
                        .onDelete(perform: deleteItems)
                        .onMove(perform: moveItems)
                    }
                        .id(UUID()) // <-- This stops causes SwiftUI to load the whole lot afresh rather than messing around trying to update things and flicke.
                        )
                
                Button(action: createNewItem) {
                    Text("Add an item")
                        .padding()
                }
                
                Button(action: saveChanges) {
                    Text("Save Changes?")
                        .padding()
                }
                
                
            }
            .navigationBarItems(leading: EditButton())
            .onAppear(perform: setupCoreData)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

