//
//  WebNewViewController.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 23-07-24.
//

import UIKit
import WebKit

class WebNewViewController: UIViewController {

    var urlStr: String?

    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Web"
        setupWebView()
        loadWebPage()
    }

    private func setupWebView() {
        
        webView = WKWebView(frame: self.view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(webView)
    }

    private func loadWebPage() {
        
        guard let urlString = urlStr, let url = URL(string: urlString) else {
            
            print("URL inválida: \(urlStr ?? "N/A")")
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

