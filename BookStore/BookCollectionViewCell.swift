//
//  BookCollectionViewCell.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/07.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: BookCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        backgroundColor = .blue
    }
    
}
