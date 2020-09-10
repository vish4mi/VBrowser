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
    var delegate: BrowserViewController?
    var selectedTab: Int!

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
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.kTabCell, for: indexPath) as! TabTableViewCell
        
        if indexPath.row < tabs.count {
            let tab: Tab = tabs[indexPath.row]
            cell.setupCell(withTitle: tab.title, andSubtitle: tab.url)
        } else {
            cell.setupCell(withTitle: "", andSubtitle: "")
        }
        
        if indexPath.row == selectedTab {
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.green.cgColor
        }
        
        return cell
    }
    
    
}

extension BrowserTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < tabs.count {
            if indexPath.row != selectedTab {
                
            }
            navigationController?.popViewController(animated: true)
        }
    }
}
