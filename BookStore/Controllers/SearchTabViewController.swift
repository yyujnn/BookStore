//
//  BookSearchViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/03.
//

import UIKit
import SnapKit

class SearchTabViewController: UIViewController {
    
    let recentBooks: [Document] = [
        Document(title: "책 제목 1", contents: "책 내용 1", url: "http://example.com/book1", isbn: "1234567890", datetime: "2024-05-10T10:00:00.000+09:00", authors: ["저자1"], publisher: "출판사1", translators: ["번역가1"], price: 10000, salePrice: 8000, thumbnail: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038", status: "판매 중"),
        Document(title: "책 제목 2", contents: "책 내용 2", url: "http://example.com/book2", isbn: "0987654321", datetime: "2024-05-11T10:00:00.000+09:00", authors: ["저자2"], publisher: "출판사2", translators: ["번역가2"], price: 12000, salePrice: 10000, thumbnail: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038", status: "절판"),
        Document(title: "책 제목 3", contents: "책 내용 3", url: "http://example.com/book3", isbn: "1357902468", datetime: "2024-05-12T10:00:00.000+09:00", authors: ["저자3"], publisher: "출판사3", translators: ["번역가3"], price: 15000, salePrice: 13000, thumbnail: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038", status: "판매 중"), Document(title: "책 제목 4", contents: "책 내용 3", url: "http://example.com/book3", isbn: "1357902468", datetime: "2024-05-12T10:00:00.000+09:00", authors: ["저자3"], publisher: "출판사3", translators: ["번역가3"], price: 15000, salePrice: 13000, thumbnail: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038", status: "판매 중"),
        Document(title: "책 제목 5", contents: "책 내용 3", url: "http://example.com/book3", isbn: "1357902468", datetime: "2024-05-12T10:00:00.000+09:00", authors: ["저자3"], publisher: "출판사3", translators: ["번역가3"], price: 15000, salePrice: 13000, thumbnail: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038", status: "판매 중")
    ]

    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        configureUI()
        configureNavigationBar()
        
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
#Preview {
    SearchTabViewController()
    // 화면 업데이트: command+option+p
}
