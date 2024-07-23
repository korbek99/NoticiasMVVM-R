//
//  ArticleViewModel.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 23-07-24.
//
import Foundation
import Combine

class ArticlesViewModel: ObservableObject {
    @Published var indicadores: [Article] = []
    private let networkService = NetworkService()
    var reloadList: (() -> Void)?
    var arrayOfList: [Article] = [] {
        didSet {
            reloadList?()
        }
    }
    
    init() {
        fetchIndicadores()
    }
    
    func fetchIndicadores() {
        networkService.fetchIndicadores { [weak self] response in
            guard let self = self, let response = response else { return }
            DispatchQueue.main.async {
                self.indicadores = response
                self.arrayOfList = self.indicadores
            }
        }
    }
}
