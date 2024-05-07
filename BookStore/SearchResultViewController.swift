//
//  SearchResultViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/06.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var searchKeyword: String? {
        didSet {
            
        }
    }
    
    var books: [Document] = []
    
    let resultCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
    }
    
    func setupSearchBar() {
        if let searchKeyword  = searchKeyword {
            searchBar.text = searchKeyword
        }
    }
    
    func fetchBookData() {
        // query: searchKeyword ?? ""
        NetworkingManager.shared.searchBooks(query: "하루키") { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(BookData.self, from: data)
                    print("Decoded data: \(decodedData)")
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

extension SearchResultViewController: UISearchBarDelegate {
    
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let paddingSpace = 5 * 4
           let availableWidth = collectionView.bounds.width - CGFloat(paddingSpace)
           let widthPerItem = availableWidth / 3
           return CGSize(width: widthPerItem, height: 280)
       }
}
#Preview {
    SearchResultViewController()
    // 화면 업데이트: command+option+p
}
