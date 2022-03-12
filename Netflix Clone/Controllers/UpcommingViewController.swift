//
//  UpcommingViewController.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 09/03/2022.
//

import UIKit

class UpcommingViewController: UIViewController {
    
    
    private var items : [Item] = [Item]()
    private let upcommingTableView : UITableView = {
       let tableView = UITableView()
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Upcomming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcommingTableView)
        upcommingTableView.delegate = self
        upcommingTableView.dataSource = self
        
        fetchUpcomming()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcommingTableView.frame = view.bounds
    }
    private func fetchUpcomming(){
        APICaller.shared.getPopular{ items in
            self.items = items
        }
        DispatchQueue.main.async { [weak self] in
            self?.upcommingTableView.reloadData()
        }
    }
}
extension UpcommingViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
            
        }
        let name = items[indexPath.row].original_name ?? items[indexPath.row].original_title ?? "Unknown"
        let url = items[indexPath.row].poster_path ?? ""
        cell.configure(with: ItemViewModel(itemName: name, posterURL: url))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension UpcommingViewController : UITableViewDelegate{
    
}
