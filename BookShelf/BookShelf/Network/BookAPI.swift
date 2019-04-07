//
//  BookAPI.swift
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

import Moya

enum BookAPI {
    case new
    case search(keyword: String, page: String)
    case detail(isbn: String)
}

extension BookAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.itbook.store/1.0")!
    }

    var path: String {
        switch self {
        case .new:
            return "/new"
        case let .search(keyword, page):
            return "/search/\(keyword)/\(page)"
        case let .detail(isbn):
            return "/books/\(isbn)"
        }
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return nil
    }


}
