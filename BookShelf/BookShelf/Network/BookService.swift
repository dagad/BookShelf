//
//  BookService.swift
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

import Foundation
import Moya

@objcMembers
class BookService: NSObject {
    static let shared = BookService()
    private let provider = MoyaProvider<BookAPI>()

    typealias NewBooksResult = Dictionary<String, Any>

    func requestNewBooks(success: @escaping (NewBooksResult?) -> Void, failure: (Error) -> Void) {
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
}
