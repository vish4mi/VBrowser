//
//  BrowserTabViewController.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 10/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit
import RealmSwift

class BrowserTabViewController: UIViewController {

    @IBOutlet weak var tabsTableView: UITableView!
    var tabs = [Tab]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension BrowserTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath)
    }
    
    
}

extension BrowserTabViewController: UITableViewDelegate {
    
}
