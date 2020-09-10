//
//  BrowserViewController.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 10/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var browserView: UIView!
    @IBOutlet weak var backwardButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var bookmarksButton: UIBarButtonItem!
    @IBOutlet weak var tabsButton: UIBarButtonItem!
    
    var currentWebView: WKWebView!
    var errorView = UIView()
    var errorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureWebView()
        configureWebViewError()
        updateNavigationToolBarButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currentWebView.frame = CGRect(x: 0.0, y: 0.0, width: browserView.bounds.width, height: browserView.bounds.height)
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func configureWebView() {
        let webconfig = WKWebViewConfiguration()
        let frame = CGRect(x: 0.0, y: 0.0, width: browserView.bounds.width, height: browserView.bounds.height)
        
        currentWebView = WKWebView(frame: frame, configuration: webconfig)
        currentWebView.navigationDelegate = self
        browserView.addSubview(currentWebView)
    }
    
    func configureWebViewError() {
        let frame = CGRect(x: 0.0, y: 0.0, width: browserView.bounds.width, height: browserView.bounds.height)
        errorView = UIView(frame: frame)
        errorView.backgroundColor = .white
        
        errorLabel = UILabel(frame: frame)
        errorLabel.backgroundColor = .white
        errorLabel.textColor = UIColor.pastelGrayColor()
        errorLabel.text = ""
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont(name: "HelveticaNeue", size: 24)
        errorLabel.numberOfLines = 0
        
        //errorView.addSubview(errorLabel)
        //browserView.addSubview(errorView)
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if currentWebView.canGoBack {
            if errorView.isDescendant(of: browserView) {
                hideWebViewError()
            } else {
                currentWebView.goBack()
            }
            searchBar.text = currentWebView.url?.absoluteString
        }
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        if currentWebView.canGoForward {
            currentWebView.goForward()
            hideWebViewError()
            searchBar.text = currentWebView.url?.absoluteString
        }
    }
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        currentWebView.reload()
    }
    
    func loadWebSite(withInput input: String, isURLDoamin isURLDomain: Bool) {
        var encodedURL: String = input.lowercased()
        
        if isURLDomain {
            if encodedURL.starts(with: "http://") {
                encodedURL = String(encodedURL.dropFirst(7))
            } else if encodedURL.starts(with: "https://") {
                encodedURL = String(encodedURL.dropFirst(8))
            }
            encodedURL = "https://" + encodedURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        } else {
            encodedURL = "https://www.google.com/search?dcr=0&q=" + encodedURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        
        if let url = URL(string: encodedURL) {
            let request = URLRequest(url: url)
            currentWebView.load(request)
            hideWebViewError()
            searchBar.text = encodedURL.lowercased()
        }
    }
    
    func displayWebViewError(withMessage meesage: String) {
        errorLabel.text = meesage
        browserView.addSubview(errorView)
        browserView.addSubview(errorLabel)
    }
    
    func hideWebViewError() {
        errorLabel.removeFromSuperview()
        errorView.removeFromSuperview()
    }
    
    func updateNavigationToolBarButtons() {
        if currentWebView.canGoBack {
            backwardButton.isEnabled = true
        } else {
            backwardButton.isEnabled = false
        }
        
        if currentWebView.canGoForward {
            forwardButton.isEnabled = true
        } else {
            forwardButton.isEnabled = false
        }
    }
}

extension BrowserViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
        if let input = searchBar.text?.trimmingCharacters(in: .whitespaces) {
            if !input.isEmpty {
                if input.hasSuffix(".com") || input.hasSuffix(".com/") || input.hasSuffix(".in") || input.hasSuffix(".in/") {
                    loadWebSite(withInput: input, isURLDoamin: true)
                } else {
                    loadWebSite(withInput: input, isURLDoamin: false)
                }
            }
        }
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "")
    }

}

extension BrowserViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    @available(iOS 13.0, *)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        decisionHandler(.allow, preferences)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started provisional navigation")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Provisional navigation failed")
        displayWebViewError(withMessage: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Committed")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished")
        updateNavigationToolBarButtons()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Navigation failed")
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, cred)
    }
    
}
