//
//  ViewController.swift
//  BaseProject
//
//  Created by Nguyen Tran on 9/23/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var tbContent: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        tb.register(HomeItemCell.self, forCellReuseIdentifier: HomeItemCell.classId)
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 60
//        tb.keyboardDismissMode = .onDrag
        return tb
    }()
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = Constants.String.searchBarPlaceholder
        sc.searchBar.sizeToFit()
        sc.searchBar.searchBarStyle = .prominent
        sc.view.isHidden = true
        
        var scope: [String] = []
        for item in CatagoryType.allCases {
            scope.append(item.rawValue)
        }
        sc.searchBar.scopeButtonTitles = scope
        sc.searchBar.delegate = self
        return sc
    }()
    
    let viewModel: HomeViewModel = HomeViewModel()
    var filteredLibType = [CatalogModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        title = viewModel.getHomeModel().title
        
//        tbContent.tableHeaderView = searchController.searchBar
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        tapGesture.cancelsTouchesInView = true
//        tbContent.addGestureRecognizer(tapGesture)
        
        
    }
    
    @objc func hideKeyboard() {
        self.searchController.searchBar.endEditing(true)
    }
    
    // search filter
    func filterContentForSearchText(searchText: String, scope: String = CatagoryType.ALL.rawValue) {
        filteredLibType.removeAll()
        let searchText = searchText.trimmingCharacters(in: .whitespaces)
        for catalog in viewModel.getContent() {
            let doesCategoryMatch = (scope == CatagoryType.ALL.rawValue) || (catalog.catalogType.rawValue == scope)
            if isSearchBarEmpty() {
                if doesCategoryMatch {
                    filteredLibType.append(catalog)
                }
            } else {
                var resultSearchText: [CatalogItemModel] = []
                for value in catalog.data ?? [] {
                    if value.title.lowercased().contains(searchText.lowercased()) ||
                        ((value.desc ?? "").lowercased().contains(searchText.lowercased())) || searchText.isEmpty {
                        resultSearchText.append(value)
                    }
                }
                if doesCategoryMatch && resultSearchText.count > 0 {
                    var model = catalog
                    model.data = resultSearchText
                    filteredLibType.append(model)
                }
            }
        }
        tbContent.reloadData()
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty() || searchBarScopeIsFiltering)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() {
            return filteredLibType.count
        }
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredLibType[section].data?.count ?? 0
        }
        return viewModel.getContent()[section].data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeItemCell.classId, for: indexPath) as? HomeItemCell else {
            fatalError("Can't dequeue reusable cell home item cell")
        }
        
        if isFiltering() {
            cell.model = filteredLibType[indexPath.section].data?[indexPath.row]
        } else {
            if let object = viewModel.getValueAt(indexPath.section),
               let value = object.data?[indexPath.row] {
                cell.model = value
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering() {
            return filteredLibType[section].catalogType.rawValue
        } else {
            return viewModel.getContent()[section].catalogType.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ContentDetailViewController()
        guard let object = isFiltering() ?
            filteredLibType[indexPath.section].data?[indexPath.row] :
                viewModel.getContent()[indexPath.section].data?[indexPath.row] else { return }
        vc.title = object.title
        vc.viewModel = ContentDetailViewModel(catalogModel: object)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Setup views
private extension HomeViewController {
    func setupViews() {
        setupTableViewContent()
    }
    
    func setupTableViewContent() {
        view.addSubview(tbContent)
        NSLayoutConstraint.activate([
            tbContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tbContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tbContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tbContent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
}

// MARK: - UIScroll view
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchController.searchBar.endEditing(true)
    }
}
