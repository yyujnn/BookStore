//
//  RecentBooksManager.swift
//  BookStore
//
//  Created by 정유진 on 5/9/24.
//

import Foundation

class RecentBooksManager {
    static let shared = RecentBooksManager()
      
    private var recentBooks: [Document] = []
    
    // 최근 본 책 목록을 추가하는 함수 (가장 앞에 담기)
    func addRecentBook(_ book: Document) {
        recentBooks.insert(book, at: 0)
    }
    
    
    // 최근 본 책 목록을 반환하는 함수
    func getRecentBooks() -> [Document] {
        return recentBooks
    }
    
    /*
     static let shared = RecentBooksManager()
     
    private let userDefaults = UserDefaults.standard
    private let recentBooksKey = "RecentBooks"
    
    // 최근 본 책 목록을 UserDefaults에 저장하는 함수
    func saveRecentBooks(_ books: [Document]) {
        do {
            let encodedData = try JSONEncoder().encode(books)
            userDefaults.set(encodedData, forKey: recentBooksKey)
        } catch {
            print("Error saving recent books: \(error)")
        }
    }
    
    // UserDefaults에서 최근 본 책 목록을 불러오는 함수
    func loadRecentBooks() -> [Document] {
        guard let encodedData = userDefaults.data(forKey: recentBooksKey) else {
            return []
        }
        do {
            let books = try JSONDecoder().decode([Document].self, from: encodedData)
            return books
        } catch {
            print("Error loading recent books: \(error)")
            return []
        }
    }
     */
}

