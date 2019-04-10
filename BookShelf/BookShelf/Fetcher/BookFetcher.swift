//
//  BookFetcher.swift
//  BookShelf
//
//  Created by Sangyeol Kang on 11/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

import Foundation
import Moya

@objc protocol BookFetcherDelegate: class {
    func fetcher(_ fetcher: BookFetcher, didFetchItemsAt indexPaths: [IndexPath])
    func fetcher(_ fetcher: BookFetcher, didUpdateTotalCount totalCount: Int)
    func fetcher(_ fetcher: BookFetcher, didOccur error: Error)
}

@objcMembers
class BookFetcher: NSObject {
    
    enum FetchState: Equatable {
        static func == (lhs: BookFetcher.FetchState, rhs: BookFetcher.FetchState) -> Bool {
            switch (lhs, rhs) {
            case (fetching, fetching), (fetched, fetched), (failed, failed):
                return true
            default:
                return false
            }
        }
        
        case fetching(request: Cancellable?)
        case fetched(item: Book)
        case failed
    }
    
    enum FetchType {
        case books
    }
    
    private(set) var totalCount = 0
    
    let fetchCount = 10
    let type: FetchType = .books
    var searchKeyword: String = ""
    
    weak var delegate: BookFetcherDelegate?
    
    private let service = BookService()
    private var states: [IndexPath: FetchState] = [:]
    
    init(type: FetchType, books: [Book] = []) {
        super.init()
        
        for (index, book) in books.enumerated() {
            let indexPath = IndexPath(item: index, section: 0)
            states[indexPath] = .fetched(item: book)
        }
    }
    
    deinit {
        print("fetcher deinit")
    }
    
    func clear() {
        totalCount = 0
        states.values.forEach { (state) in
            if case let .fetching(cancellable) = state, let request = cancellable {
                if !request.isCancelled {
                    request.cancel()
                }
            }
        }
        states = [:]
    }
    
    func bookAtIndexPath(_ indexPath: IndexPath) -> Book? {
        if let state = states[indexPath] {
            switch state {
            case let .fetched(item):
                return item
            default:
                return nil
            }
        }
        return nil
    }
    
    func state(at indexPath: IndexPath) -> FetchState? {
        return states[indexPath]
    }
    
    func isFetchableAt(_ indexPath: IndexPath) -> Bool {
        if let state = states[indexPath] {
            switch state {
            case .failed:
                return true
            default:
                return false
            }
        } else {
            return true
        }
    }
    
    func fetchBookWithKeyword(_ keyword: String, searchitemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if isFetchableAt(indexPath) {
                let page = Int(indexPath.item / fetchCount) + 1
                fetch(page: page, section: indexPath.section)
            }
        }
    }
    
    func cancelFetching(itemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let state = states[indexPath], case let .fetching(cancellable) = state, let request = cancellable {
                if !request.isCancelled {
                    request.cancel()
                }
            }
        }
    }
}

// MARK: - Search
extension BookFetcher {
    private func search(keyword: String, page: String) {
        BookService.shared.searchBooksBy(keyword: keyword, page: page,
                                         success: { [weak self] book in
                                            guard let strongSelf = self else { return }
                                            
            self?.delegate?.fetcher(strongSelf, didFetchItemsAt: )
        },
                                         failure: { error in
            
        })
    }
}

// MARK: - Fetch
extension BookFetcher {
    private func fetch(page: Int, section: Int) {
        var request: Cancellable?
        
        BookService.shared.searchBooksBy(keyword: searchKeyword, page: String(page), success: { book in
            
        }, failure: { error in
            
        })
        
        if let request = request {
            for item in ((page - 1) * fetchCount)..<(page * fetchCount) {
                let indexPath = IndexPath(item: item, section: section)
                if states[indexPath] == nil {
                    states[indexPath] = .fetching(request: request)
                }
            }
        }
    }
}

