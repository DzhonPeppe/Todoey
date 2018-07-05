//
//  Category.swift
//  Tadoey
//
//  Created by John Peppe on 7/3/18.
//  Copyright © 2018 John Peppe. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
