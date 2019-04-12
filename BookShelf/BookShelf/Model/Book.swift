//
//  Book.swift
//  BookShelf
//
//  Created by Sangyeol Kang on 07/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

import Mapper

@objcMembers
class Book: NSObject, NSCopying, Mappable {

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

    static func mock() -> Book {
        let book = Book()
        book.title = "mockTitle"
        book.subtitle = "mockSubTitle"
        book.authors = "mookAuthos"
        book.publisher = "mookPublisher"
        book.isbn10 = String(Int.random(in: 0..<10000000000))
        book.isbn13 = String(Int.random(in: 0..<10000000000000))
        book.pages = "999"
        book.year = "1990.08.06"
        book.rating = "5"
        book.desc = "mookDescription"
        book.price = "$999"
        book.imageSource = "https://itbook.store/img/books/9781617294136.png"
        book.url = "https://itbook.store/books/9781617294136"
        book.pdf = ["Chapter 2": "https://itbook.store/files/9781617294136/chapter2.pdf",
                    "Chapter 5": "https://itbook.store/files/9781617294136/chapter5.pdf"]
        return book
    }

    override init() {
        super.init()
    }

    convenience init(with book: Book) {
        self.init()
        error = book.error
        title = book.title
        subtitle = book.subtitle
        authors = book.authors
        publisher = book.publisher
        isbn10 = book.isbn10
        isbn13 = book.isbn13
        pages = book.pages
        year = book.year
        rating = book.rating
        desc = book.desc
        price = book.price
        imageSource = book.imageSource
        url = book.url
        pdf = book.pdf
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
        guard let target = object as? Book else { return false }
        if target.isbn13 == isbn13, target.isbn10 == isbn10 {
            return true
        } else {
            return false
        }
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Book(with: self)
    }

}

