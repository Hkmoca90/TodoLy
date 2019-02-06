//
//  Category.swift
//  TodoLy
//
//  Created by Hector Moreno on 2/5/19.
//  Copyright © 2019 Hector Moreno. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()

}
