//
//  CoreDataManager.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/09.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate가 초기화되지 않았습니다.")
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    static func saveBookData(book: Document, completion: @escaping (Bool) -> Void) {
        guard let context = CoreDataManager.context else {
            completion(false)
            return
        }
        
        let bookData = Book(context: context)
        bookData.title = book.title
        bookData.authors = book.authors
        bookData.publisher = book.publisher
       
        do {
            try context.save()
            completion(true)
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false)
        }
    }

}

