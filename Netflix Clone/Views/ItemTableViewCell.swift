//
//  ItemTableViewCell.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 12/03/2022.
//

import UIKit



class ItemTableViewCell: UITableViewCell {

    static let identifier = "ItemTableViewCell"
    
    
    
    private let posterImage : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    private let itemName : UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let playButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImage)
        contentView.addSubview(itemName)
        contentView.addSubview(playButton)
        
        applyConstraints()
    }
    
    private func applyConstraints(){
       let posterImageConstraints = [
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImage.widthAnchor.constraint(equalToConstant: 100)
            ]
        let itemNameConstraints = [
            itemName.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor,constant: 20),
            itemName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30),
            itemName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -40)
        ]
        let playButtonConstaints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ]
        NSLayoutConstraint.activate(playButtonConstaints)
        NSLayoutConstraint.activate(posterImageConstraints)
        NSLayoutConstraint.activate(itemNameConstraints)
        
    }
    
    public func configure(with vm : ItemViewModel ){
        guard let posterPath = URL(string: "https://image.tmdb.org/t/p/w500\(vm.posterURL)") else { return }
        posterImage.sd_setImage(with: posterPath, completed: nil)
        itemName.text = vm.itemName
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
