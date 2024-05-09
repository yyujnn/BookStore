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
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        displayBookDetails()
        setupScrollView()
        setupButtonStackView()
        setupButtons()
        addRecentBook()
        
    }
    
    // MARK: - 최근 본 책
    func addRecentBook() {
        if let book = book {
            print("책 상세 페이지")
            print("load 확인: \(RecentBooksManager.shared.getRecentBooks())")
            RecentBooksManager.shared.addRecentBook(book)
        }
    }
    
    
    // MARK: - Constraints Setup
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
        }
    }
    
    // MARK: - 버튼 이벤트 처리
    private func setupButtons() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        
        guard let book = book else { return }
        print("담는 책 제목: \(book.title)")
        
        CoreDataManager.saveBookData(book: book) { success in
            if success {
                print("CoreData 저장 성공")
            } else {
                print("CoreData 저장 실패")
            }
        }
    }
    
    // MARK: - 화면 데이터
    func displayBookDetails() {
        guard let book = book else { return }
        
        if let thumbnailURL = URL(string: book.thumbnail) {
            let options: KingfisherOptionsInfo = [
                .processor(BlurImageProcessor(blurRadius: 30)),
                .cacheOriginalImage
            ]
            thumbnailImageView.kf.setImage(with: thumbnailURL)
            blurredImageView.kf.setImage(with: thumbnailURL, options: options)
        }
        titleLabel.text = book.title
        authorsLabel.text = "\(book.authors.joined(separator: ", ")) 지음"
        publisherLabel.text = book.publisher
        priceLabel.text = book.price.formattedPriceWithWon()
        contentsLabel.text = book.contents
    }
}
