//
//  HeroHeaderView.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 10/03/2022.
//

import UIKit
import SDWebImage

class HeroHeaderView: UIView {

    
    private let heroImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playButton : UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let downloadButton : UIButton = {
       let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private func applyConstraints(){
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: width / 5),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -width / 5),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    public func configure(with itemVM : ItemViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(itemVM.posterURL)") else { return }
        heroImageView.sd_setImage(with: url, completed: nil)
    }

}
