//
//  SavedBooksViewController.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/03.
//

import UIKit

class SavedBooksViewController: UIViewController {
    
    var savedBooks: [Book] = []
    
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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedBooks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
    }
    
    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
    }
    
    // MARK: - 레이아웃 설정
    private func setupConstraints() {
        [titleLabel, bookCountLabel, tableView].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        bookCountLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(bookCountLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - 코어데이터 불러오기
    func loadSavedBooks() {
        savedBooks = CoreDataManager.fetchCoreData()
        self.tableView.reloadData()
        self.bookCountLabel.text = "전체 \(savedBooks.count)권"
    }

}
// MARK: - UITableViewDataSource
extension SavedBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        let book = savedBooks[indexPath.row]
        cell.setData(book)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SavedBooksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let bookToDelete = savedBooks[indexPath.row]

            CoreDataManager.deleteBookData(book: bookToDelete) { success in
                if success {
                    self.loadSavedBooks()
                } else {
                    print("데이터 삭제 실패")
                }
            }
        }
    }
}
