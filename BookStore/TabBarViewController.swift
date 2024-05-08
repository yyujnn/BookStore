//
//  TabBarViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/03.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTabItem()
    
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
        self.tabBar.backgroundColor = .systemGray5
        self.tabBar.tintColor = .black
    }
    
    func configureTabItem() {

        let searchVC = SearchTabViewController()
        let savedBooksVC = SavedBooksViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        
        searchVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(named: "searchIcon"), selectedImage: nil)
        savedBooksVC.tabBarItem = UITabBarItem(title: "내서재", image: UIImage(named: "saveIcon"), selectedImage: nil)

        self.viewControllers = [searchNav, savedBooksVC]
        self.selectedIndex = 0
    }

}
