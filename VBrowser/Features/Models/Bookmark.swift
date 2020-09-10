//
//  Bookmark.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 11/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import Foundation
import RealmSwift

class Bookmark: Object {
    dynamic var url: String = ""
    dynamic var title: String = ""
    
    override static func primaryKey() -> String? {
        return "url"
}
    
    var bookmarkDescription: String {
        let urlDescription = "URL: \(url)\n"
        let titleDescription = "Title: \(title)\n"
        return "Bookmark information: \n\(urlDescription)\(titleDescription)\n"
    }
}
