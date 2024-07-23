//
//  Webservice.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 09-01-24.
//


import Foundation

class Webservice {
    
    func getArticles( completion: @escaping ([Article]?) -> ()) {
        let utilEndpoint = UtilsEndpoints()

        let endpointData = utilEndpoint.getEndpoint(fromName: "crearIssue")!
        let urlhttp = URL(string: endpointData.url.absoluteString)

        URLSession.shared.dataTask(with: urlhttp!) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                do {
                    let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                    if let articleList = articleList {
                        completion(articleList.articles)
                    }
                    print(articleList?.articles)
                } catch {
                        print(error)
                }
            }
            
        }.resume()
        
    }

}

