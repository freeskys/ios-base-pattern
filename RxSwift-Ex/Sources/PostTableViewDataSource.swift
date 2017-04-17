//
//  PostTableViewDataSource.swift
//  iOS-Base-Pattern
//
//  Created by Harditya on 3/10/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class PostTableViewDataSource: NSObject, UITableViewDataSource {
    
//    typealias Element = [Post]
    
    var posts = [Post]()
//    var posts: Element?
    
    // MARK: - Table view data source
    
//    func tableView(_ tableView: UITableView, observedEvent: Event<[Post]>) {
//        switch observedEvent {
//        case .next(let posts):
//            print("SUCCESS")
//            self.posts = posts
//            
//            tableView.reloadData()
//        case .error(let error):
//            print("ERROR: \(error)")
//            
//        case .completed:
//            print("COMPLETED")
//        }
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostTableViewCell
        
        // Configure the cell...
        let post = posts[indexPath.row]
        cell?.configure(post: post)
        return cell!
    }
    
}
