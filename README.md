## Intro

This is an iOS SwiftUI app that demonstrates the ForEach component being used with a Core Data Entity that has a Many-to-Many relationship with itself and uses Xcode's data modeller Arrangement Ordered option to facilitate arbitrary ordering of those relationships. 

Why this rather than directly storing the order as a "priority" attribute on the entity? Storing as part of the relationship is more flexible; it allows ordering as part of new lists without needing more Entity "priority" attributes to be added for each list. 

## Installation

Works for me (tm) with Xcode 11.6 and targets iOS 13.5

## Running
Should run on any suitable simulator or device.

![](assets/app_running.png "picture of app running on iPhone simulator")

- Tap "Add an item" to add an item.
- Swipe left to delete an item.
- Tap "Edit" to delete and rearrange items and "Done" when finished.
- Tap "Save Changes?" to persist changes to Core Data backend.
- Uninstall to remove app and its data.

## Notes

### Data Model
There's only one Core Data entity called an `Item`. This Entity has:
- A title string 
- UUID attribute which it it constrained to be unique by.
- A Root flag boolean to indicate if the Item is the Root item from which all others are its children.
- childrenList and parentList relationships with itself that are the inverses of each other.
- It's been configured so that Codegen is manual.

![Item Core Data Entity](assets/item_data_model.png "Item Core Data model editor")

The `Arrangement Ordered` option has been ticked for the children and parent relationships. Which, according to official [documentation](https://developer.apple.com/documentation/coredata/modeling_data/configuring_relationships) does the following: *"Arrangement: Select the Ordered checkbox to specify that the relationship has an inherent ordering, and to generate an ordered **mutable** set."*. 

![Item Core Data Relationship](assets/item_relationship_options.png "Item Core Data model editor")

The `Editor> Create NSManagedObjectSubclass Subclass...` was then used to make the Core Data class boiler plate easier to inspect and play with (not that I did much of that). This is in `Item+CoreDataClass.swift` and `Item_CoreDataProperties.swift`

### Bug?
It looks like either the official documentation is incorrect or the code created by `Editor> Create NSManagedObjectSubclass Subclass...` is a bit broken. As for the both the parent and children lists, the generated code ends up as the **immutable** `NSOrderedSet`. When the  official documentation strongly implies it it should be  `NSMutableOrderedSet`. I've worked around in the code by copying copying to `NSMutableOrderedSet`, reordering and then replacing.

If anyone can clarify I will update here.