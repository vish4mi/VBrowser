//
//  Engine.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 11/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import Foundation
import RealmSwift

class Engine: Object {
    @objc dynamic var url: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var imageName: String = ""
    @objc dynamic var isDefault: Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }
    
    var engineDescription: String {
        let urlDescription = "URL: \(url)\n"
        let titleDescription = "Title: \(name)\n"
        let idDescription = "Id: \(id)\n"
        let imageNameDescription = "ImageName: \(name)\n"
        let isDefaultDescription = "IsDefault: \(id)\n"

        return "Engine information: \n\(urlDescription)\(titleDescription)\(idDescription)\(imageNameDescription)\(isDefaultDescription)\n"
    }
}
