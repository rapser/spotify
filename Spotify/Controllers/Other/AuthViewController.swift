//
//  AuthViewController.swift
//  Spotify
//
//  Created by Miguel Angel Tomairo Mendez on 25-09-23.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private let webView: WKWebView = {
        
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, 
                                configuration: config)
        
        return webView
    }()
    
    public var completionHandler: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign In"
        view.backgroundColor = .systemBackground
        
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        guard let url = AuthManager.shared.signInURL else {
            return
        }

        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
    }
}

extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {return}
        
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value else {
            return
        }
        
        webView.isHidden = true
        
        print("code: \(code)")
        
        AuthManager.shared.exchangeCodeForToken(code: code) {[weak self] (success) in
            
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
            
        }
        
    }
}