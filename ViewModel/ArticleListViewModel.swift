//
//  ArticleListViewModel.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 09-01-24.
//


import Foundation

struct ArticleListViewModel {
    let articles: [Article]
}

extension ArticleListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
    
}

struct ArticleViewModel {
    public let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var author: String {
        return self.article.author ?? "S/N"
    }
    var title: String {
        return self.article.title
    }
    
    var description: String {
        return self.article.description ?? "Not Context"
    }
}


