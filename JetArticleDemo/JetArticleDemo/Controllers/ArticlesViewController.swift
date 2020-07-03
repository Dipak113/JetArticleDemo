//
//  ArticlesViewController.swift
//  JetArticleDemo
//
//  Created by Dipak Dhondge on 03/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import UIKit

class ArticlesViewController: BaseViewController {

    @IBOutlet weak var articleTableView: UITableView!
    // In MVVM architecture, controller will have instance of view model
    private var articlesViewModel: ArticlesViewModel = ArticlesViewModel()
    private var currPage = 1
    private let defaultPageSize = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performInitialSetupWhileLoadingView()
        articlesViewModel.fetchArticles()
    }
    
    /// Function to perform or setup initial settings
    private func performInitialSetupWhileLoadingView() {
        articlesViewModel.delegate = self
        articleTableView.rowHeight = UITableView.automaticDimension
        articleTableView.estimatedRowHeight = 100
    }
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesViewModel.articleObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.articleTableViewCell, for: indexPath) as! ArticleTableViewCell
        cell.setArticlesOnCellAt(indexPath: indexPath, articleObjects: articlesViewModel.articleObjects)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: UIScreen.main.bounds.width)
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let fetchNextPage = (self.currPage * defaultPageSize) - 1 == indexPath.row
        if fetchNextPage == true {
            self.currPage = self.currPage + 1
            // Request presenter to fetch data
            articlesViewModel.fetchArticles(atPage: currPage)
        }
    }
}

extension ArticlesViewController: ArticleResponse {
    func showLoader() {
        self.view.showBlurLoader()
    }
    
    func hideLoader() {
        self.view.removeBluerLoader()
    }
    
    func reloadTableView() {
        self.articleTableView.reloadData()
    }
    
    func showDataLoadedAlert() {
        self.showAlert(withTitle: Constants.Alerts.alert, withMessage: Constants.Alerts.allDataLoaded)

    }
    
    func showErrorAlert() {
        self.showAlert(withTitle: Constants.Alerts.alert, withMessage: Constants.Alerts.errorMessage)
    }
}



