//
//  SearchResultViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/06.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var searchKeyword: String?
    
    var books: [Document] = []
    
    // MARK: - 컴포넌트
    let resultCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        configureUI()
        configureNavigationBar()
        setupSearchBar()
        fetchBookData()
    }
    
    // MARK: - UI 구성
    func setupSearchBar() {
        if let searchKeyword  = searchKeyword {
            searchBar.text = searchKeyword
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupConstraints() {
        [searchBar, resultCountLabel, collectionView].forEach {
            view.addSubview($0)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        resultCountLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(resultCountLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func configureUI() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
    }
    
    func configureNavigationBar() {
        navigationItem.title = "검색결과"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    // MARK: - 검색 결과 데이터
    func fetchBookData() {
        NetworkingManager.shared.searchBooks(query: searchKeyword ?? "") { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(BookData.self, from: data)
                    self.books = decodedData.documents
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.resultCountLabel.text = "검색결과 \(self.books.count)"
                    }
                } catch {
                    print("Failed to parse data: \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print("Failed to fetch book data: \(error.localizedDescription)")
            }
        }
    }
}
// MARK: - UISearchBarDelegate
extension SearchResultViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        print("검색어: \(searchText)")
        
        searchKeyword = searchText
        fetchBookData()
        
        searchBar.resignFirstResponder()
    }
}

// MARK: - UICollectionView
extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        
        let book = books[indexPath.item]
        cell.setData(with: book)
        return cell
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.item]
        showBookDetailModal(book: selectedBook)
    }
    
    private func showBookDetailModal(book: Document) {
        let bookDetailVC = BookDetailViewController()
        bookDetailVC.book = book
        
        self.modalPresentationStyle = .fullScreen
        self.present(bookDetailVC, animated: true, completion: nil)
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 5 * 4
        let availableWidth = collectionView.bounds.width - CGFloat(paddingSpace)
        let widthPerItem = availableWidth / 3
        return CGSize(width: widthPerItem, height: 280)
    }
}

