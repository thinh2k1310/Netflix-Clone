//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 10/03/2022.
//

import UIKit

protocol CollectionViewTableViewCellDelegate : AnyObject {
    func didTapCell(_ cell : CollectionViewTableViewCell,_ viewModel : ItemPreviewViewModel )
}

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewCell"
    private var items : [Item] = [Item]()
    
    weak var delegate : CollectionViewTableViewCellDelegate?
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        return collectionView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemMint
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError() 
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func configure( with items : [Item]){
        self.items = items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}
extension CollectionViewTableViewCell : UICollectionViewDelegate{
    
}
extension CollectionViewTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let url = items[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        guard let itemName = item.original_name ?? item.original_title, let itemOverview = item.overview else {
            return
        }
        APICaller.shared.getYoutubeMovies(with: itemName + " trailer"){ result in
            self.delegate?.didTapCell(self, ItemPreviewViewModel(name: itemName, overview: itemOverview, youtubeElement: result))
        }
        
    }
    
}
