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
    }
    
    func configureTabItem() {

        let bookSearchVC = BookSearchViewController()
        let savedBooksVC = SavedBooksViewController()
        
        bookSearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        savedBooksVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        // 아이템 이미지 추가
        //secondVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "2.circle"), selectedImage: UIImage(systemName: "2.circle.fill"))

        self.viewControllers = [bookSearchVC, savedBooksVC]
        self.selectedIndex = 0
    }

}
