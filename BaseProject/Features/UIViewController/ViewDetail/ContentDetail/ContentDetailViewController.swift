//
//  ContentDetailViewController.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/23/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

class ContentDetailViewController: UIViewController {

    lazy var tbContent: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        tb.register(ContentDetailCell.self, forCellReuseIdentifier: ContentDetailCell.classId)
        tb.separatorStyle = .none
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 50
        return tb
    }()
    
    var viewModel: ContentDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}


// MARK: - tbContent delegate, datasource
extension ContentDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentDetailCell.classId, for: indexPath) as? ContentDetailCell else {
            fatalError("Can't dequeue réuable cell")
        }
        cell.model = viewModel?.selectedItemAt(indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = viewModel?.selectedItemAt(indexPath.row) else { return }
        if let value = object.value,
           let url = URL(string: value), object.isUrl {
            let vc = WebDetailViewController()
            vc.url = url
            vc.title = object.value
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

// MARK: - setup view
extension ContentDetailViewController {
    func setupViews() {
        view.addSubview(tbContent)
        
        NSLayoutConstraint.activate([
            tbContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tbContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tbContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tbContent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
