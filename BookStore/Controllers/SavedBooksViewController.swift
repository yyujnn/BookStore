//
//  SavedBooksViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/03.
//

import UIKit

class SavedBooksViewController: UIViewController {
    
    var savedBooks: [Book] = [] // 저장된 책 목록
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "내 서재"
        return label
    }()
    
    let bookCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedBooks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        view.addSubview(titleLabel)
        view.addSubview(bookCountLabel)
        view.addSubview(collectionView)
    }
    
    // MARK: - Constraints Setup
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        bookCountLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(bookCountLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - 코어데이터 불러오기
    func loadSavedBooks() {
        savedBooks = CoreDataManager.fetchCoreData()
        self.collectionView.reloadData()
        self.bookCountLabel.text = "전체 \(savedBooks.count)권"
    }
    
}
// MARK: - UICollectionViewDataSource

extension SavedBooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let book = savedBooks[indexPath.item]
        cell.displaySavedBook(book)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SavedBooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 5 * 4
        let availableWidth = collectionView.bounds.width - CGFloat(paddingSpace)
        let widthPerItem = availableWidth / 3
        return CGSize(width: widthPerItem, height: 280)
    }
}
