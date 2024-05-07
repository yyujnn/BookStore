//
//  BookSearchViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/03.
//

import UIKit
import SnapKit

class SearchTabViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Books"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        setupSearchBar()
        configureNavigationBar()
        
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupConstraints() {
       
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
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
#Preview {
    SearchTabViewController()
    // 화면 업데이트: command+option+p
}
