//
//  DownloadViewController.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 09/03/2022.
//

import UIKit

class DownloadViewController: UIViewController {
    
    private var downloadedItems : [MediaItem] = []

    private let downloadTable : UITableView = {
       let tableView = UITableView()
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(downloadTable )
        
        downloadTable.delegate = self
        downloadTable.dataSource = self
        fetchDownloadedItemsFromLocalStorage()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchDownloadedItemsFromLocalStorage()
        }
        
    }
    private func fetchDownloadedItemsFromLocalStorage(){
        DatapersistenceManager.shared.fetchingItemsFromDatabase(){ result in
            self.downloadedItems = result
            DispatchQueue.main.async {
                self.downloadTable.reloadData()
            }
            
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
    

    
}

extension DownloadViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        downloadedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
            
        }
        let name = downloadedItems[indexPath.row].original_name ?? downloadedItems[indexPath.row].original_title ?? "Unknown"
        let url = downloadedItems[indexPath.row].poster_path ?? ""
        cell.configure(with: ItemViewModel(itemName: name, posterURL: url))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            DatapersistenceManager.shared.deleteItemWith(model: downloadedItems[indexPath.row]){
                 print("Item was deleted !")
                self.downloadedItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = downloadedItems[indexPath.row]
        guard let itemName = item.original_name ?? item.original_title, let itemOverview = item.overview else {
            return
        }
        APICaller.shared.getYoutubeMovies(with: itemName + " trailer"){ result in
            DispatchQueue.main.async {
                let vc =  ItemPreviewViewController()
                vc.configure(with: ItemPreviewViewModel(name: itemName, overview: itemOverview, youtubeElement: result))
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
}
 
