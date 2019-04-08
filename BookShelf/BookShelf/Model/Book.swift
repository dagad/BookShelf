//
//  Book.swift
//  BookShelf
//
//  Created by Sangyeol Kang on 07/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

import Foundation
import Mapper

@objcMembers
class Book: NSObject, Mappable {
    
    let error: String
    let title: String
    let subtitle: String
    let authors: String
    let publisher: String
    let isbn10: String
    let isbn13: String
    let pages: String
    let year: String
    let rating: String
    let desc: String
    let price: String
    let imageSource: String
    let url: String
    let pdf: [String: String]
    
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

