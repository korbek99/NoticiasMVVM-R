//
//  ViewController.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 09-01-24.
//
import UIKit

class NewsViewController: UIViewController {
    
    private var articleListVM: ArticleListViewModel?
    
    var listMenus = [Article]()
    var searching = false
    var searchedMenu = [Article]()
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(ArticleTableNewViewCell.self, forCellReuseIdentifier: "ArticleTableNewViewCell")
        table.rowHeight = 200.0
        table.separatorColor = .orange
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .white
        setUpTableView()
        setup()
        configureSearchController()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = .done
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Buscar por nombre"
        searchController.searchBar.tintColor = .black
        searchController.searchBar.backgroundColor = .white
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        Webservice().getArticles { [weak self] articles in
            guard let self = self else { return }
            if let articles = articles {
                self.articleListVM = ArticleListViewModel(articles: articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension NewsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        searchedMenu = listMenus.filter { $0.author!.lowercased().contains(searchText.lowercased()) }
        searching = !searchText.isEmpty
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedMenu.removeAll()
        tableView.reloadData()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return searching ? 1 : (articleListVM?.numberOfSections ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? searchedMenu.count : (articleListVM?.numberOfRowsInSection(section) ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableNewViewCell", for: indexPath) as? ArticleTableNewViewCell else {
            fatalError("ArticleTableNewViewCell not found")
        }
        
        if searching {
            let article = searchedMenu[indexPath.row]
            let articleModel = ArticleTableNewModel(
                autor: article.author ?? "Unknown",
                title: article.title,
                desc: article.description ?? "",
                imageURL: ""
            )
            cell.configure(articleModel)
        } else {
            guard let articleVM = articleListVM?.articleAtIndex(indexPath.row) else { return cell }
            let articleModel = ArticleTableNewModel(
                autor: articleVM.author,
                title: articleVM.title,
                desc: articleVM.description,
                imageURL: ""
            )
            cell.configure(articleModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let article: Article
           if searching {
               article = searchedMenu[indexPath.row]
           } else {
               guard let articleVM = articleListVM?.articleAtIndex(indexPath.row) else { return }
            article = articleVM.article
           }

        if let navigationController = navigationController {
            let detailVC = NewsDetailViewController()
            detailVC.article = article
            navigationController.pushViewController(detailVC, animated: true)
        } else {
            print("NavigationController is nil")
        }
       }
}
