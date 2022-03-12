//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 11/03/2022.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    public func configure(with url : String) {
       guard let posterPath = URL(string: "https://image.tmdb.org/t/p/w500\(url)") else { return }
       posterImageView.sd_setImage(with: posterPath, completed: nil)
        
    }
    
}
