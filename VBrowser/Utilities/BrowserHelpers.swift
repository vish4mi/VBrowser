//
//  BrowserHelpers.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 11/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import Foundation
import RealmSwift

func isRealmPopulatedWithDefaultTab() -> Bool {
    let realm = try! Realm()
    if realm.objects(Tab.self).count > 0 {
        return true
    }
    return false
}

func populatedRealmWithDefaultTab() {
    let realm = try! Realm()
    let defaultTab: Tab = Tab(value: ["url":"www.google.com", "initialURL":"https://www.google.com", "title": "Hello"])
    
    try! realm.write {
        realm.add(defaultTab)
    }
    
    
}
