//
//  Article.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 09-01-24.
//

import Foundation


struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}


struct Source: Decodable {
    let id: String?
    let name: String
}


struct ArticleList: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

