//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 13/03/2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate {
    func didTapItem(_ viewModel : ItemPreviewViewModel )
}

class SearchResultsViewController: UIViewController {
    
    
    public var items : [Item] = []
    public var delegate : SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10  ,height: UIScreen.main.bounds.height / 3 - 15 )
        
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
}

extension SearchResultsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.row]
        let posterPath = item.poster_path ?? ""
        cell.configure(with: posterPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = items[indexPath.row]
        guard let itemName = item.original_name ?? item.original_title, let itemOverview = item.overview else {
            return
        }
        
        APICaller.shared.getYoutubeMovies(with: itemName + " trailer"){ result in
            self.delegate?.didTapItem(ItemPreviewViewModel(name: itemName, overview: itemOverview, youtubeElement: result))
        }
        
    }
    
    
}
extension SearchResultsViewController : UICollectionViewDelegate{
    
}
    
    

