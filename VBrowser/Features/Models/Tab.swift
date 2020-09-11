//
//  Tab.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 11/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import Foundation
import RealmSwift

class Tab: Object {
    @objc dynamic var url: String = ""
    @objc dynamic var initialURL: String = ""
    @objc dynamic var title: String = ""
    
    var tabDescription: String {
        let urlDescription = "URL: \(url)\n"
        let initialURLDescription = "Intial Description: \(initialURL)\n"
        let titleDescription = "Title: \(title)\n"
        return "Tab information: \n\(urlDescription)\(initialURLDescription)\(titleDescription)\n"
    }
    
}
