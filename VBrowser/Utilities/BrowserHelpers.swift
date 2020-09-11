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
    let defaultEngine = getDefaultSearchEngine()
    let engines = realm.objects(Engine.self)
    
    for engine in engines {
        if engine.id == defaultEngine {
            let url = engine.url
            let initialURL = url
            let title = "Welcome"
            
            let defaultTab: Tab = Tab(value: ["url":url, "initialURL":initialURL, "title": title])
            try! realm.write {
                realm.add(defaultTab)
            }
            break
        }
    }
}

func isRealmPopulatedWithEngines() -> Bool {
    let realm = try! Realm()
    if realm.objects(Engine.self).count > 0 {
        return true
    }
    return false
}

func getDefaultSearchEngine() -> Int {
    let realm = try! Realm()
    let engines = realm.objects(Engine.self)
    
    for engine in engines {
        if engine.isDefault == true {
            return engine.id
        }
    }
    return 0
}

func populatedRealmWithEngines() {
    let realm = try! Realm()
    
    for searchEngine in searchEngines {
        let id: Int = searchEngine["id"] as! Int
        let data: [String: String] = searchEngine["data"] as! [String: String]
        let url: String = data["url"]!
        let name: String = data["name"]!
        let imageName: String = data["imageName"]!
        
        let engine: Engine = Engine(value: ["id":id, "name":name, "url":url, "isDefault":(id == 0 ? true : false), "imageName":imageName])
        try! realm.write {
            realm.add(engine)
        }
    }
}
