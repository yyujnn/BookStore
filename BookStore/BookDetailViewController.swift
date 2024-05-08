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
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private let borderView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        return view
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(systemName: "xmark") {
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            button.setImage(tintedImage, for: .normal)
            button.tintColor = .black
        }
        button.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
        return button
    }()

    
    private let saveButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(systemName: "heart.fill") {
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            button.setImage(tintedImage, for: .normal)
            button.tintColor = .white
        }
        button.setTitle("  담기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [closeButton, saveButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
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
        setupCloseButton()
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
            $0.height.equalTo(102)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(45)
            $0.leading.trailing.equalTo(buttonView).inset(20)
        }
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupConstraints() {
           
        view.backgroundColor = .white
        
        // Image Constraints
        [blurredImageView, titleLabel, authorsLabel, publisherLabel, borderView, priceLabel, borderView2, contentsLabel].forEach {
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

        // Label Constraints
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(blurredImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        authorsLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        publisherLabel.snp.makeConstraints {
            $0.top.equalTo(authorsLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        borderView.snp.makeConstraints {
            $0.top.equalTo(publisherLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        borderView2.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(borderView2.snp.bottom).offset(20)
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
        
        // temp data
        if let thumbnailURL = URL(string: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038") {
            let options: KingfisherOptionsInfo = [
                .processor(BlurImageProcessor(blurRadius: 30)),
                .cacheOriginalImage
            ]
            
            thumbnailImageView.kf.setImage(with: thumbnailURL)
            blurredImageView.kf.setImage(with: thumbnailURL, options: options)
        }
        
        titleLabel.text = "미움받을 용기"
        authorsLabel.text = "기시미 이치로 지음"
        publisherLabel.text = "인플루엔셜"
        priceLabel.text = "14,900원"
        contentsLabel.text = "인간은 변할 수 있고, 누구나 행복해 질 수 있다. 단 그러기 위해서는 ‘용기’가 필요하다고 말한 철학자가 있다. ㄱ바로 프로이트, 융과 함께 ‘심리학의 3대 거장’으로 일컬어지고 있는 알프레드 아들러다. 『미움받을 용기』는 아들러 심리학에 관한 일본의 1인자 철학자 기시미 이치로와 베스트셀러 작가인 고가 후미타케의 저서로, 아들러의 심리학을 ‘대화체’로 쉽고 맛깔나게 정리하고 있다. 아들러 심리학을 공부한 철학자와 세상에 부정적이고 열등감 많은인간은 변할 수 있고, 누구나 행복해 질 수 있다. 단 그러기 위해서는 ‘용기’가 필요하다고 말한 철학자가 있다. ㄱ바로 프로이트, 융과 함께 ‘심리학의 3대 거장’으로 일컬어지고 있는 알프레드 아들러다. 『미움받을 용기』는 아들러 심리학에 관한 일본의 1인자 철학자 기시미 이치로와 베스트셀러 작가인 고가 후미타케의 저서로, 아들러의 심리학을 ‘대화체’로 쉽고 맛깔나게 정리하고 있다. 아들러 심리학을 공부한 철학자와 세상에 부정적이고 열등감 많은"
    }
     
}

#Preview {
    BookDetailViewController()
    // 화면 업데이트: command+option+p
}
