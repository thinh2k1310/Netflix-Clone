//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 09/03/2022.
//

import UIKit

enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcomming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    
    let sectionTitles : [String] = ["Trending Movies","Trending Tv","Popular","Upcomming Movies","Top Rated "]
    
    private let homeFeedTable : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    private var headerView : HeroHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        

        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        configureNavbar()
        
        headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: UIScreen.main.bounds.height * 0.6))
        homeFeedTable.tableHeaderView = headerView
        configureHeaderView()
        
        
    }
    func configureNavbar(){
        var image = UIImage(named: "logoNetflix")
        image = image?.withRenderingMode(.alwaysOriginal)
        let netflixBtn = UIButton(type: .custom)
        netflixBtn.setBackgroundImage(image, for: .normal)
        netflixBtn.frame = CGRect(x: 0, y: 0, width: 18, height: 30)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
        view.addSubview(netflixBtn)
        let leftBtn = UIBarButtonItem(customView: view)
        navigationItem.leftBarButtonItem = leftBtn
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    private func configureHeaderView(){
        APICaller.shared.getTrendingMovies(){ movies in
            guard let randomMovie = movies.randomElement() else { return }
            guard let moviesName = randomMovie.original_title ?? randomMovie.original_name,
                  let posterURL = randomMovie.poster_path else {
                      return
                  }
            let vm = ItemViewModel(itemName: moviesName, posterURL: posterURL)
            self.headerView?.configure(with: vm)
        }
    }
}
// MARK: - TABLEVIEW DATASOURCE
extension HomeViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell
        else {
            return UITableViewCell()
        }
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue :
            APICaller.shared.getTrendingMovies{ movies in
                cell.configure(with: movies)
            }
        case Sections.TrendingTv.rawValue :
            APICaller.shared.getTrendingTvs{ tvs in
                cell.configure(with: tvs)
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular{ items in
                cell.configure(with: items)
            }
        case Sections.Upcomming.rawValue:
            APICaller.shared.getUpcommingMovies{ items in
                cell.configure(with: items)
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated{ items in
                cell.configure(with: items)
            }
        default:
            return UITableViewCell()
        }
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight : .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: header.bounds.width, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
}
extension HomeViewController : UITableViewDelegate{
    
}

extension HomeViewController : CollectionViewTableViewCellDelegate{
    func didTapCell(_ cell: CollectionViewTableViewCell, _ viewModel: ItemPreviewViewModel) {
        DispatchQueue.main.async {
            let vc =  ItemPreviewViewController()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
