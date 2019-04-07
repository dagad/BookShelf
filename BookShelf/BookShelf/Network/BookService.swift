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

    typealias NewBooksResult = Dictionary<String, Any>

    func requestNewBooks(success: @escaping (NewBooksResult?) -> Void, failure: @escaping (Error) -> Void) {
        provider.request(.new) { result in
            switch result {
            case let .success(response):
                let data = response.data
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NewBooksResult
                success(json ?? NewBooksResult())
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func requestBookDetailWith(isbn: String, success: @escaping (Book?) -> Void, failure: @escaping (Error) -> Void) {
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
}
