//
//  DetailViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/03.
//

import UIKit
import SnapKit
import Kingfisher

class BookDetailViewController: UIViewController {
    
    var book: Document?
    
    private var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var blurredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        // 여기에 이미지 설정 및 흐리게 처리 로직 추가
        return imageView
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [closeButton, saveButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private lazy var buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).cgColor
        return view
    }()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        displayBookDetails()
        setupScrollView()
        setupButtonStackView()
    }
    
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().offset(-100)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(contentsLabel.snp.bottom).offset(20)
        }
    }
    
    private func setupButtonStackView() {

        view.addSubview(buttonView)
        buttonView.addSubview(buttonStackView)
        
        buttonView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(45)
            $0.leading.trailing.equalTo(buttonView).inset(20)
        }
    }
    
    private func setupConstraints() {
           
        view.backgroundColor = .white
        
        [blurredImageView, titleLabel, authorsLabel, priceLabel, contentsLabel].forEach {
            contentView.addSubview($0)
        }
        
        blurredImageView.addSubview(thumbnailImageView)

        blurredImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentView)
            $0.width.equalToSuperview()
            $0.height.equalTo(500)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(40)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(blurredImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        authorsLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(authorsLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func displayBookDetails() {
        /*
        guard let book = book else { return }
        
        // Set thumbnail image using Kingfisher
        if let thumbnailURL = URL(string: book.thumbnail) {
            thumbnailImageView.kf.setImage(with: thumbnailURL)
        }

        // Set other details
        titleLabel.text = book.title
        authorsLabel.text = "Authors: \(book.authors.joined(separator: ", "))"
        priceLabel.text = "Price: \(book.price)"
        contentsLabel.text = book.contents
         */ 
        
        if let thumbnailURL = URL(string: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038") {
            let options: KingfisherOptionsInfo = [
                .processor(BlurImageProcessor(blurRadius: 30)),
                .cacheOriginalImage
            ]
            
            thumbnailImageView.kf.setImage(with: thumbnailURL)
            blurredImageView.kf.setImage(with: thumbnailURL, options: options)
        }
        
        titleLabel.text = "미움받을 용기"
        authorsLabel.text = "기시미 이치로"
        priceLabel.text = "14,900"
        contentsLabel.text = "인간은 변할 수 있고, 누구나 행복해 질 수 있다. 단 그러기 위해서는 ‘용기’가 필요하다고 말한 철학자가 있다. ㄱ바로 프로이트, 융과 함께 ‘심리학의 3대 거장’으로 일컬어지고 있는 알프레드 아들러다. 『미움받을 용기』는 아들러 심리학에 관한 일본의 1인자 철학자 기시미 이치로와 베스트셀러 작가인 고가 후미타케의 저서로, 아들러의 심리학을 ‘대화체’로 쉽고 맛깔나게 정리하고 있다. 아들러 심리학을 공부한 철학자와 세상에 부정적이고 열등감 많은인간은 변할 수 있고, 누구나 행복해 질 수 있다. 단 그러기 위해서는 ‘용기’가 필요하다고 말한 철학자가 있다. ㄱ바로 프로이트, 융과 함께 ‘심리학의 3대 거장’으로 일컬어지고 있는 알프레드 아들러다. 『미움받을 용기』는 아들러 심리학에 관한 일본의 1인자 철학자 기시미 이치로와 베스트셀러 작가인 고가 후미타케의 저서로, 아들러의 심리학을 ‘대화체’로 쉽고 맛깔나게 정리하고 있다. 아들러 심리학을 공부한 철학자와 세상에 부정적이고 열등감 많은"
    }
     
}

#Preview {
    BookDetailViewController()
    // 화면 업데이트: command+option+p
}
