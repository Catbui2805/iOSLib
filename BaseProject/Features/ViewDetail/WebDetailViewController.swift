//
//  WebDetailViewController.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/23/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit
import WebKit

class WebDetailViewController: UIViewController {
    
    var url: URL? {
        didSet {
            guard let url = url else { return }
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    lazy var webView: WKWebView = {
        let wv = WKWebView()
        wv.navigationDelegate = self
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension WebDetailViewController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension WebDetailViewController: WKNavigationDelegate {
    
}
