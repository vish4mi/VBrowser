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
        return tableView .dequeueReusableCell(withIdentifier: "abc", for: indexPath)
    }
    
    
}

extension BookmarkViewController: UITableViewDelegate {
    
}
