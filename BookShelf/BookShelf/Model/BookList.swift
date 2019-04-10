//
//  BookList.swift
//  BookShelf
//
//  Created by devdagad on 11/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

import Mapper

@objcMembers
class BookList: NSObject, Mappable {
    
    var totalCount: Int = 0
    var books: [Book] = []

    required init(map: Mapper) throws {
        totalCount = map.optionalFrom("total") ?? 0
        books = map.optionalFrom("books") ?? []
    }
}


