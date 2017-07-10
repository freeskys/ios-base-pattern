//
//  BaseTableViewController.swift
//  iOS-Base-Pattern
//
//  Created by Harditya on 4/17/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Init
        initData()
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Init
    
    func initData() {
        
    }
    
    func initUI() {
        // Self sizing cell
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.initRefreshUI()
    }
    
    func initRefreshUI() {
        refresh.addTarget(self, action: #selector(BaseTableViewController.reload), for: .valueChanged)
        self.refreshControl = refresh
    }
    
    // MARK: - Refresh control
    
    func reload() {
        
    }

}
