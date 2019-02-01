//
//  ItemList.swift
//  TodoLy
//
//  Created by Hector Moreno on 1/31/19.
//  Copyright © 2019 Hector Moreno. All rights reserved.
//

import Foundation

class ItemList: Codable {
    var title: String?
    var isCheck: Bool?

    init(title: String, isCheck: Bool) {
        self.title = title
        self.isCheck = isCheck
    }
}
