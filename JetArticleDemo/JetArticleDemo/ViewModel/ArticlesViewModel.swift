//
//  ArticlesViewModel.swift
//  JetArticleDemo
//
//  Created by Dipak Dhondge on 03/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import Foundation
import UIKit

protocol ArticleResponse: class {
    func reloadTableView()
    func showDataLoadedAlert()
    func showErrorAlert()
    func showLoader()
    func hideLoader()
}

class ArticlesViewModel: NSObject {
    
    // weak declaration to avoid retain cycle
    var articleObjects: [Article] = []
    weak var delegate: ArticleResponse?
    
    /// Function to call fetch api from model file
    /// - Parameter page: page number
    func fetchArticles(atPage page:Int = 1) {
        if page == 1 {
            articleObjects.removeAll()
        }
        self.delegate?.showLoader()
        ServerManager.sharedInstance.getArticleListFromServer(pageCount: page) { (articles, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.delegate?.hideLoader()
                    self.delegate?.showErrorAlert()
                }
            }
            else {
                if let articles = articles {
                    if articles.count == 0 {
                        self.delegate?.showDataLoadedAlert()
                    }
                    DispatchQueue.main.async {
                        self.articleObjects.append(contentsOf: articles)
                        self.delegate?.reloadTableView()
                        self.delegate?.hideLoader()
                    }
                }
            }
        }
    }
}
