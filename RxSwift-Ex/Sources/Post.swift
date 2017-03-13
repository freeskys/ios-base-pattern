//
//  Post.swift
//  iOS-Base-Pattern
//
//  Created by Harditya on 3/10/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift
import RxRealm

class Post: Object, Mappable {
    
    dynamic var userId: Int = -1
    dynamic var id: Int = -1
    dynamic var title: String = ""
    dynamic var body: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
