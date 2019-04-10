//
//  BookService.swift
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper

@objcMembers
class BookService: NSObject {
    static let shared = BookService()
    private let provider = MoyaProvider<BookAPI>()

    func requestNewBooks(success: @escaping ([Book]?) -> Void, failure: @escaping (Error) -> Void) {
        provider.request(.new) { result in
            switch result {
            case let .success(response):
                if let books = try? response.map(to: [Book].self, keyPath: "books") {
                    success(books)
                } else {
                    success(nil)
                }
//                do {
//                    let books = try response.map(to: [Book].self, keyPath: "books")
//                    success(books)
//                } catch {
//                    print("\(error)")
//                    failure(error)
//                }
            case let .failure(error):
                print(error)
                failure(error)
            }
        }
    }
    
    func requestBookDetailWith(isbn: String, success: @escaping (Book) -> Void, failure: @escaping (Error) -> Void) {
        provider.request(.detail(isbn: isbn)) { result in
            switch result {
            case let .success(response):
                do {
                    let book = try response.map(to: Book.self)
                    success(book)
                } catch {
                    print("\(error)")
                    failure(error)
                }
            case let .failure(error):
                print(error)
                failure(error)
            }
        }
    }
    
    func searchBooksBy(keyword: String, page: String, success: @escaping (BookList?) -> Void, failure: @escaping (Error) -> Void) {
        provider.request(.search(keyword: keyword, page: page)) { result in
            switch result {
            case let .success(response):
                if let bookList = try? response.map(to: BookList.self) {
                    success(bookList)
                } else {
                    success(nil)
                }
            case let .failure(error):
                print(error)
                failure(error)
            }
        }
    }
}
