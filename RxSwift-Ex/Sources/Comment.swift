//
//  Comment.swift
//  RxSwift-Ex
//
//  Created by Harditya on 2/8/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift
import RxRealm

class Comment: Object, Mappable {
    
    dynamic var postId: Int = -1
    dynamic var id: Int = -1
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var body: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        postId <- map["postId"]
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        body <- map["body"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
