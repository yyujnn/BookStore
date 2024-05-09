//
//  BookCollectionViewCell.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/07.
//

import UIKit
import SnapKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: BookCollectionViewCell.self)

    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        [thumbnailImageView, titleLabel, authorLabel, publisherLabel].forEach {
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(contentView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        publisherLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.lessThanOrEqualToSuperview().inset(5)
        }
        
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
    
    func setData(with book: Document) {
        titleLabel.text = book.title
        authorLabel.text = book.authors.isEmpty ? "" : book.authors.joined(separator: ", ")
        publisherLabel.text = book.publisher
        
        // 썸네일 이미지 처리
        if let thumbnailURL = URL(string: book.thumbnail) {
            thumbnailImageView.kf.setImage(with: thumbnailURL)
        } else {
            thumbnailImageView.image = UIImage(named: "placeholder")
        }
    }
    
    func displaySavedBook(_ book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.authors?.isEmpty ?? true ? "" : (book.authors?.joined(separator: ", ") ?? "")
        publisherLabel.text = book.publisher
        
        // 썸네일 이미지 처리
        if let thumbnailURL = book.thumbnail, let thumbnailURL = URL(string: thumbnailURL) {
            thumbnailImageView.kf.setImage(with: thumbnailURL, placeholder: UIImage(named: "placeholder"))
        } else {
            thumbnailImageView.image = UIImage(named: "placeholder")
        }
    }

}
