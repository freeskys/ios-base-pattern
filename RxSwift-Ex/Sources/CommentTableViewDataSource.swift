//
//  CommentTableViewDataSource.swift
//  iOS-Base-Pattern
//
//  Created by Harditya on 3/10/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import Foundation
import UIKit

class CommentTableViewDataSource: NSObject, UITableViewDataSource {
    
    var comments = [Comment]()
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CommentTableViewCell
        
        // Configure the cell...
        let comment = comments[indexPath.row]
        cell?.configure(comment: comment)
        return cell!
    }
    
}
