//
//  Item.swift
//  Tadoey
//
//  Created by John Peppe on 7/3/18.
//  Copyright © 2018 John Peppe. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
