//
//  ItemPreviewViewController.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 13/03/2022.
//

import UIKit
import WebKit




class ItemPreviewViewController: UIViewController {
    
    private let nameLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22 , weight : .bold)
        label.text = "Spider man"
        return label
    }()
    private let overview : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18 , weight : .regular)
        label.numberOfLines = 0
        label.text = "Spider man No Way Home Spider man No Way Home Spider man No Way Home Spider man No Way Home Spider man No Way Home Spider man No Way Home Spider man No Way Home"
        return label
    }()
    private let downloadButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let webView : WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(nameLabel)
        view.addSubview(overview)
        view.addSubview(downloadButton)
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
        
        applyConstraints()
        
    }
    private func applyConstraints(){
        let webviewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250)
        ]
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: webView.bottomAnchor,constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20)
        
        ]
        let overviewConstraits = [
            overview.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 15),
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        let downloadButtonConstraints = [
            downloadButton.topAnchor.constraint(equalTo: overview.bottomAnchor,constant: 20),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(webviewConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(overviewConstraits)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        
    }
    
    func configure(with viewModel : ItemPreviewViewModel){
        nameLabel.text = viewModel.name
        overview.text = viewModel.overview
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(viewModel.youtubeElement.id.videoId)") else {
            return
            
        }
        webView.load(URLRequest(url: url))
    }

}
