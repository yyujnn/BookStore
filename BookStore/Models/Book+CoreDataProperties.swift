//
//  Book+CoreDataProperties.swift
//  BookStore
//
//  Created by 정유진 on 5/9/24.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var authors: [String]?
    @NSManaged public var publisher: String?
    @NSManaged public var title: String?
    @NSManaged public var thumbnail: String?

}

extension Book : Identifiable {

}
