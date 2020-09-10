//
//  BookmarkViewController.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 10/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController {

    @IBOutlet weak var bookmarkTableView: UITableView!
    var bookmarks = [Bookmark]()
    var delegate: BrowserViewController?
    
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
    
    
}

extension BookmarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < bookmarks.count {
            let bookmark = bookmarks[indexPath.row]
            
        }
        navigationController?.popViewController(animated: true)
    }
}
