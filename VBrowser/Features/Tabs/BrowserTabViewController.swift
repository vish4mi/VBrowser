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

    @IBAction func addTabButtonClicked(_ sender: UIBarButtonItem) {
        let realm = try! Realm()
        let newTab: Tab = Tab()
        
        try! realm.write {
            realm.add(newTab)
        }
        tabs.append(newTab)
        selectedTab = tabs.count - 1
        tabsTableView.reloadData()
        delegate?.addTab(newTab)
        navigationController?.popViewController(animated: true)

    }
}

extension BrowserTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.kTabCell, for: indexPath) as! TabTableViewCell
        cell.configureCell()
        if indexPath.row < tabs.count {
            let tab: Tab = tabs[indexPath.row]
            cell.setupCell(withTitle: tab.title, andSubtitle: tab.url)
        } else {
            cell.setupCell(withTitle: "", andSubtitle: "")
        }
        
        if indexPath.row == selectedTab {
            cell.addShadow()
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row > 0 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.row < tabs.count {
                let deletedtab: Tab = tabs.remove(at: indexPath.row)
                delegate?.deleteTab(deletedtab, indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension BrowserTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < tabs.count {
            if indexPath.row != selectedTab {
                delegate?.selectedTab = indexPath.row
                delegate?.loadWebView()
            }
            navigationController?.popViewController(animated: true)
        }
    }
}
