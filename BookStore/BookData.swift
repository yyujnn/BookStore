//
//  BookData.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/07.
//

import Foundation

struct BookData: Codable {
    let title: String
    let contents: String
    let url: String
    let isbn: String
    let datetime: String
    let authors: [String]
    let publisher: String
    let translators: [String]
    let price: Int
    let salePrice: Int
    let thumbnail: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case title, contents, url, isbn, datetime, authors, publisher, translators, price, thumbnail, status
        case salePrice = "sale_price"
    }
}
