//
//  BookmarkViewController.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 10/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarkViewController: UIViewController {

    @IBOutlet weak var bookmarkTableView: UITableView!
    var bookmarks = [Bookmark]()
    var delegate: BrowserViewController?
    var selectedTab: Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension BookmarkViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: Identifier.kBookmarkCell, for: indexPath) as! BookmarkTableViewCell
        if indexPath.row < bookmarks.count {
            let bookmark: Bookmark = bookmarks[indexPath.row]
            cell.setupCell(withTitle: bookmark.title, andSubtitle: bookmark.url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.row < bookmarks.count {
                let deletedBookmark: Bookmark = bookmarks.remove(at: indexPath.row)
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(deletedBookmark)
                }
                delegate?.loadBookmarks()
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
}

extension BookmarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < bookmarks.count {
            let bookmark = bookmarks[indexPath.row]
            delegate?.loadWebSite(withInput: bookmark.url, isURLDoamin: true, andURLProcessed: true)
        }
        navigationController?.popViewController(animated: true)
    }
}
