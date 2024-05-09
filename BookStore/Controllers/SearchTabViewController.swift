//
//  BookSearchViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/03.
//

import UIKit
import SnapKit

class SearchTabViewController: UIViewController {
    
    var recentBooks: [Document] = []
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Books"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let recentBooksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "최근 본 책"
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRecentBooks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        configureUI()
        configureNavigationBar()
        setupTapGesture()
    }
    
    // MARK: - UI 구성
    func loadRecentBooks() {
        recentBooks = RecentBooksManager.shared.getRecentBooks()
        collectionView.reloadData()
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configureUI() {
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
    }
    
    func setupConstraints() {
       
        view.addSubview(searchBar)
        view.addSubview(recentBooksLabel)
        view.addSubview(collectionView)
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        recentBooksLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(recentBooksLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(260)
        }
        
    }
    
    func configureNavigationBar() {
        let logoImageView = UIImageView(image: UIImage(named: "bookLogo"))
        logoImageView.contentMode = .scaleAspectFit
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
        logoContainer.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoContainer)
        navigationController?.navigationBar.tintColor = .darkGray
    }
    
    
}
// MARK: - UISearchBarDelegate
extension SearchTabViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        print("검색어: \(searchText)")
        
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchKeyword = searchText
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}
// MARK: - UICollectionView
extension SearchTabViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        let book = recentBooks[indexPath.item]
        cell.setData(with: book)
        return cell
    }
}

extension SearchTabViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 5 * 4
        let availableWidth = collectionView.bounds.width - CGFloat(paddingSpace)
        let widthPerItem = availableWidth / 3.5
        return CGSize(width: widthPerItem, height: 260)
    }
}
