//
//  Book.swift
//  BookShelf
//
//  Created by Sangyeol Kang on 07/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

import Mapper

@objcMembers
class Book: NSObject, Mappable {

    var error: String = ""
    var title: String = ""
    var subtitle: String = ""
    var authors: String = ""
    var publisher: String = ""
    var isbn10: String = ""
    var isbn13: String = ""
    var pages: String = ""
    var year: String = ""
    var rating: String = ""
    var desc: String = ""
    var price: String = ""
    var imageSource: String = ""
    var url: String = ""
    var pdf: [String: String] = [String: String]()

    override init() {
        super.init()
    }
    
    required init(map: Mapper) throws {
        error = map.optionalFrom("error") ?? ""
        title = map.optionalFrom("title") ?? ""
        subtitle = map.optionalFrom("subtitle") ?? ""
        authors = map.optionalFrom("authos") ?? ""
        publisher = map.optionalFrom("publisher") ?? ""
        isbn10 = map.optionalFrom("isbn10") ?? ""
        isbn13 = map.optionalFrom("isbn13") ?? ""
        pages = map.optionalFrom("pages") ?? ""
        year = map.optionalFrom("year") ?? ""
        rating = map.optionalFrom("rating") ?? ""
        desc = map.optionalFrom("desc") ?? ""
        price = map.optionalFrom("price") ?? ""
        imageSource = map.optionalFrom("image") ?? ""
        url = map.optionalFrom("url") ?? ""
        pdf = map.optionalFrom("pdf") ?? [String: String]()
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let target = object as? Book, target.isbn13.count > 0, isbn13.count > 0 else { return false }
        if target.isbn13 == isbn13 {
            return true
        } else {
            return false
        }
    }
}

