//
//  BookSearchViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/03.
//

import UIKit
import SnapKit

class BookSearchViewController: UIViewController {
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "BookStore"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Books"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupConstraints()
        setupSearchBar()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupConstraints() {
        
        [logoLabel, searchBar].forEach {
            view.addSubview($0)
        }
        
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(30)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(logoLabel.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    
}
// MARK: - UISearchBarDelegate
extension BookSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        print("검색어: \(searchText)")
    }
}

#Preview {
    BookSearchViewController()
    // 화면 업데이트: command+option+p
}
