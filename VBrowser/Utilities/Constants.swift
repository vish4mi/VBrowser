//
//  Constants.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 11/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import Foundation

struct SegueID {
    static let kTabSegue = "tabSegueIdentifier"
    static let kBookmarkSegue = "bookmarkSegueIdentifier"
}

struct Identifier {
    static let kTabCell = "TabTableViewCellIdentifier"
    static let kBookmarkCell = "BookmarkTableViewCellIdentifier"
    static let kBottomSheetCell = "BottomSheetCellIdentifier"
}

enum SearchEngine: Int, Hashable {
    case google = 1
    case ask
    case bing
    case yahoo
    case duckduckGo
    
    var imageName: String {
        switch self {
        case .google:
            return "google"
        case .ask:
            return "ask"
        case .bing:
            return "bing"
        case .yahoo:
            return "yahoo"
        case .duckduckGo:
            return "duckduckGo"
        }
    }
    
}

struct NibName {
    static let kBottomSheet = "BottomSheetTableViewCell"
}

let searchEngines = [["id": 1, "data":["name": "Google", "url": "https://www.google.com/search?dcr=0&q="]],
                     ["id": 2, "data":["name": "Ask.com", "url": "https://www.ask.com/web?o=0&l=dir&qo=serpSearchTopBox&q="]],
                     ["id": 3, "data":["name": "Bing", "url": "https://www.bing.com/search?q="]],
                     ["id": 4, "data":["name": "Yahoo", "url": "https://in.search.yahoo.com/search?p="]],
                     ["id": 5, "data":["name": "DuckDuckGo", "url": "https://duckduckgo.com/?q="]]]

