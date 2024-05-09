//
//  CoreDataManager.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/09.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let entityName = "Book"
    
    static let context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate가 초기화되지 않았습니다.")
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - SAVE
    static func saveBookData(book: Document, completion: @escaping (Bool) -> Void) {
        guard let context = context else {
            completion(false)
            return
        }
        
        let bookData = Book(context: context)
        bookData.title = book.title
        bookData.authors = book.authors
        bookData.publisher = book.publisher
        bookData.thumbnail = book.thumbnail
       
        do {
            try context.save()
            completion(true)
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // MARK: - READ
    static func fetchCoreData() -> [Book] {
        guard let context = context else { return [] }
        let fetchRequest = NSFetchRequest<Book>(entityName: entityName)
        
        do {
            let bookList = try context.fetch(fetchRequest)
            bookList.forEach {
                print($0.title ?? "title")
                print($0.authors ?? ["author"])
                print($0.publisher ?? "publisher")
            }
            return bookList
        } catch {
            print("코어 데이터 fetch error: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - DELETE
    static func deleteBookData(book: Book, completion: @escaping (Bool) -> Void) {
        guard let context = context else {
            completion(false)
            return
        }
        
        context.delete(book)
        
        do {
            try context.save()
            completion(true)
        } catch {
            print("코어데이터 delete error: \(error.localizedDescription)")
            completion(false)
        }
    }
}

