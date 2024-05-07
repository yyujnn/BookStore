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
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        [thumbnailImageView, titleLabel, authorLabel, priceLabel, publisherLabel].forEach {
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(contentView.snp.width).multipliedBy(0.8) // 이미지 높이를 셀의 너비의 80%로 설정
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        publisherLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.lessThanOrEqualToSuperview().inset(5)
        }
        
    }
    
    private func configureUI() {
        backgroundColor = .blue
    }
    
    func setData(with book: Document) {
        titleLabel.text = book.title
        authorLabel.text = book.authors?.isEmpty ?? true ? "" : book.authors!.joined(separator: ", ")
        priceLabel.text = book.salePrice != nil ? "가격: \(book.salePrice!)" : ""
        publisherLabel.text = book.publisher ?? ""
        
        // 썸네일 이미지 처리
        if let thumbnailURL = URL(string: book.thumbnail ?? "") {
            thumbnailImageView.kf.setImage(with: thumbnailURL)
        } else {
            // 썸네일 URL이 없는 경우 기본 이미지 또는 에러 처리를 수행할 수 있습니다.
            thumbnailImageView.image = UIImage(named: "placeholder")
        }
    }

}
