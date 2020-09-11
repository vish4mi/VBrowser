//
//  BrowserViewController.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 10/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class BrowserViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var browserView: UIView!
    @IBOutlet weak var backwardButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var bookmarksButton: UIBarButtonItem!
    @IBOutlet weak var tabsButton: UIBarButtonItem!
    
    var currentWebView: WKWebView?
    var errorView = UIView()
    var errorLabel = UILabel()
    
    var bookmarks = [Bookmark]()
    var tabs = [Tab]()
    var webviews = [WKWebView]()
    var selectedTab: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBookmarks()
        loadTabs()
        configureSearchBar()
        configureWebViewError()
        loadWebView()
        updateNavigationToolBarButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currentWebView?.frame = CGRect(x: 0.0, y: 0.0, width: browserView.bounds.width, height: browserView.bounds.height)
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func configureWebView() -> WKWebView {
        let webconfig = WKWebViewConfiguration()
        let frame = CGRect(x: 0.0, y: 0.0, width: browserView.bounds.width, height: browserView.bounds.height)
        
        let webView = WKWebView(frame: frame, configuration: webconfig)
        webView.navigationDelegate = self
        currentWebView = webView
        return webView
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
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueID.kTabSegue {
            let tabsViewController = segue.destination as! BrowserTabViewController
            tabsViewController.tabs = self.tabs
            tabsViewController.delegate = self
            tabsViewController.selectedTab = selectedTab
            
        } else if segue.identifier == SegueID.kBookmarkSegue {
            let bookmarkViewController = segue.destination as! BookmarkViewController
            bookmarkViewController.bookmarks = self.bookmarks
            bookmarkViewController.delegate = self
        }
    }
    
    @IBAction func bookmarkButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueID.kBookmarkSegue, sender: self)
    }
    
    @IBAction func tabsButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueID.kTabSegue, sender: self)
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if currentWebView?.canGoBack ?? false {
            if errorView.isDescendant(of: browserView) {
                hideWebViewError()
            } else {
                currentWebView?.goBack()
            }
            searchBar.text = currentWebView?.url?.absoluteString
        }
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        if currentWebView?.canGoForward ?? false {
            currentWebView?.goForward()
            hideWebViewError()
            searchBar.text = currentWebView?.url?.absoluteString
        }
    }
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        currentWebView?.reload()
        searchBar.text = currentWebView?.url?.absoluteString
    }
    
    func loadWebView() {
        if var aWebView = currentWebView {
            aWebView.removeFromSuperview()
            aWebView = webviews[selectedTab]
            browserView.addSubview(aWebView)
            
            currentWebView = aWebView
            
            if aWebView.url == nil && !tabs[selectedTab].url.isEmpty {
                loadWebSite(withInput: tabs[selectedTab].url, isURLDoamin: true, andURLProcessed: true)
            } else {
                searchBar.text = currentWebView?.url?.absoluteString
            }
            updateNavigationToolBarButtons()
        }
    }
    
    func loadWebSite(withInput input: String, isURLDoamin isURLDomain: Bool, andURLProcessed isURLPreprocessed: Bool) {
        var encodedURL: String = input.lowercased()
        
        if !isURLPreprocessed {
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
        }
        
        if let url = URL(string: encodedURL) {
            let request = URLRequest(url: url)
            currentWebView?.load(request)
            hideWebViewError()
            searchBar.text = encodedURL.lowercased()
            
            let tab: Tab = tabs[selectedTab]
            let realm = try! Realm()
            try! realm.write {
                tab.initialURL = encodedURL.lowercased()
            }
            
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
        if currentWebView?.canGoBack ?? false {
            backwardButton.isEnabled = true
        } else {
            backwardButton.isEnabled = false
        }
        
        if currentWebView?.canGoForward ?? false {
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
                    loadWebSite(withInput: input, isURLDoamin: true, andURLProcessed: false)
                } else {
                    loadWebSite(withInput: input, isURLDoamin: false, andURLProcessed: false)
                }
            }
        }
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if let url = currentWebView?.url?.absoluteString {
            let realm = try! Realm()
            let newBookmark: Bookmark = Bookmark(value: ["url": url, "title": currentWebView?.title])
            
            try! realm.write {
                realm.add(newBookmark, update: .all)
            }
            loadBookmarks()
        }
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
        let tab: Tab = tabs[selectedTab]
        let realm = try! Realm()
        try! realm.write {
            if let title = currentWebView?.title, let url = currentWebView?.url?.absoluteString {
                tab.title = title
                tab.url = url
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Navigation failed")
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, cred)
    }
    
}

extension BrowserViewController {
    func loadBookmarks() {
        let realm = try! Realm()
        let results = realm.objects(Bookmark.self)
        bookmarks.removeAll()
        for result in results {
            bookmarks.append(result)
        }
        
    }
}

extension BrowserViewController {
    func loadTabs() {
        let realm = try! Realm()
        let results = realm.objects(Tab.self)
        
        for result in results {
            webviews.append(configureWebView())
            tabs.append(result)
        }
        selectedTab = 0
    }
}

//Mark:- Tab methods
extension BrowserViewController {
    func addTab(_ tab: Tab) {
        tabs.append(tab)
        selectedTab = tabs.count - 1
        webviews.append(configureWebView())
        loadWebView()
    }
    
    func deleteTab(_ tab: Tab, _ tabIndex: Int) {
        if tabIndex < tabs.count && tabIndex < webviews.count {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(tab)
            }
            tabs.remove(at: tabIndex)
            webviews.remove(at: tabIndex)
            if selectedTab == tabIndex {
                selectedTab = tabIndex - 1
                loadWebView()
                navigationController?.popViewController(animated: true)
                
            } else if selectedTab > tabIndex {
                selectedTab = selectedTab - 1
            }
        }
    }
}
