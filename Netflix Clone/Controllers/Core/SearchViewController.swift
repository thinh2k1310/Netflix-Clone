//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 09/03/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var items : [Item] = []
    
    private let discoverTableView : UITableView = {
       let tableView = UITableView()
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        return tableView
    }()
    private let searchView : UISearchController = {
       let search = UISearchController(searchResultsController: SearchResultsViewController())
        search.searchBar.placeholder = " Search here ..."
        search.searchBar.searchBarStyle = .minimal
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        view.addSubview(discoverTableView)
        discoverTableView.dataSource = self
        discoverTableView.delegate = self
        
        navigationItem.searchController = searchView
        
        fetchDiscoverMovies()
        
        searchView.searchResultsUpdater = self
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTableView.frame = view.bounds
    }
    public func fetchDiscoverMovies(){
        APICaller.shared.discoverMovies(){ movies in
            self.items = movies
            DispatchQueue.main.async {
                self.discoverTableView.reloadData()
            }
        }
    }
}

extension SearchViewController : UITableViewDelegate {

}

extension SearchViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath ) as?
                ItemTableViewCell else { return UITableViewCell() }
        let item = items[indexPath.row]
        let title = item.original_title ?? item.original_name ?? "Unknown"
        let posterPath = item.poster_path ?? ""
        cell.configure(with: ItemViewModel(itemName: title, posterURL: posterPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text , !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else {
                  return
              }
        APICaller.shared.search(for: query){ results in
            DispatchQueue.main.async {
                resultController.items = results
                resultController.searchResultsCollectionView.reloadData()
            }
        }
    }
    
    
}
