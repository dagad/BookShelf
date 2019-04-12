//
//  BookFetcher.swift
//  BookShelf
//
//  Created by Sangyeol Kang on 11/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

import Foundation
import Moya

/**
 BookFetcher
 SearchViewController에서 채택한 UICollectionViewDataSourcePrefetching을 지원하는 클래스
 세가지 FetchState를 가지고 서버에서 가져오는 book데이터를 비동기적으로 View에 업데이트한다
 */

@objc protocol BookFetcherDelegate: class {
    func fetcher(_ fetcher: BookFetcher, didFetchItemsAt indexPaths: [IndexPath])
    func fetcher(_ fetcher: BookFetcher, didUpdateTotalCount totalCount: Int)
    func fetcher(_ fetcher: BookFetcher, didOccur error: Error)
}

@objc enum FetchState: Int {
    case fetching
    case fetched
    case failed
}

@objc enum FetchType: Int {
    case books
}

@objcMembers
class BookFetcher: NSObject {

    private(set) var totalCount = 0
    
    let fetchCount = 10
    let type: FetchType = .books
    
    weak var delegate: BookFetcherDelegate?
    
    private let service = BookService()
    private var states: [IndexPath: FetchState] = [:]
    private var books: [IndexPath: Book] = [:]
    private var request: [IndexPath: Cancellable] = [:]
    
    init(type: FetchType, books: [Book] = []) {
        super.init()
        
        for (index, book) in books.enumerated() {
            let indexPath = IndexPath(item: index, section: 0)
            self.states[indexPath] = .fetched
            self.books[indexPath] = book
        }
    }
    
    deinit {
        print("fetcher deinit")
    }
    
    func clear() {
        totalCount = 0
        for key in states.keys where states[key] == .fetching {
            if let cancellable = request[key], !cancellable.isCancelled {
                cancellable.cancel()
            }
        }

        states = [:]
        books = [:]
        request = [:]
    }
    
    func bookAtIndexPath(_ indexPath: IndexPath) -> Book? {
        if let state = states[indexPath] {
            switch state {
            case .fetched:
                return books[indexPath]
            default:
                return nil
            }
        }
        return nil
    }
    
    func stateAtIndexPath(_ indexPath: IndexPath) -> FetchState {
        return states[indexPath] ?? .failed
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
    
    func fetchBookWithKeyword(_ keyword: String, searchitemsAt indexPaths: [IndexPath]?) {
        guard let indexPaths = indexPaths else {
            search(keyword:keyword, page: "1")
            return
        }
        for indexPath in indexPaths {
            if isFetchableAt(indexPath) {
                let page = Int(indexPath.item / fetchCount) + 1
                search(keyword:keyword, page: String(page))
            }
        }
    }
}

// MARK: - Search
extension BookFetcher {
    private func search(keyword: String, page: String) {
        guard let pageIntValue = Int(page) else { return }
        let cancellable = BookService.shared.searchBooksBy(keyword: keyword, page: page,
                                         success: { [unowned self] bookList in
                                            guard let bookList = bookList else { return }
                                            let books = bookList.books
                                            let newTotalCount = bookList.totalCount
                                            if self.totalCount != Int(newTotalCount) {
                                                self.totalCount = Int(newTotalCount) ?? 0
                                                self.delegate?.fetcher(self, didUpdateTotalCount: self.totalCount)
                                            }
                                            var indexPaths: [IndexPath] = []
                                            for (index, book) in books.enumerated() {
                                                let indexPath = IndexPath(item: (pageIntValue - 1) * self.fetchCount + index, section: 0)
                                                self.states[indexPath] = .fetched
                                                self.books[indexPath] = book
                                                indexPaths.append(indexPath)
                                            }
                                            self.delegate?.fetcher(self, didFetchItemsAt: indexPaths)
        },
                                         failure: { error in
                                            self.delegate?.fetcher(self, didOccur: error)
        })

        for item in ((pageIntValue - 1) * fetchCount)..<(pageIntValue * fetchCount) {
            let indexPath = IndexPath(item: item, section: 0)
            if states[indexPath] == nil {
                states[indexPath] = .fetching
                request[indexPath] = cancellable
            }
        }
    }
}

