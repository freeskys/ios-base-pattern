//
//  TableViewController.swift
//  RxSwift-Ex
//
//  Created by Harditya on 2/9/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class TableViewController: UITableViewController, CommentViewModel {

    let disposeBag = DisposeBag()
    var refresh = UIRefreshControl()
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Comments
        self.comment().subscribe(onNext: { [weak self] (comment: [Comment]) in
            print("Success")
            self?.realmData()
        }, onError: { (error: Error) in
            print("Error")
            self.realmData()
        }, onCompleted: {
            print("Completed")
        }).addDisposableTo(disposeBag)
        
        refresh.backgroundColor = UIColor.red
        refresh.tintColor = UIColor.white
        refresh.addTarget(self, action: #selector(TableViewController.reload), for: .valueChanged)
        self.refreshControl = refresh
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    func realmData() {
        // Realm
        do {
            let realm = try Realm()
            self.comments = realm.objects(Comment.self).toArray()
            
            self.tableView.reloadData()
        } catch (let error) {
            print("[TableViewController] ERROR: \(error)")
        }
    }
    
    // MARK: - Refresh control

    func reload() {
        // Comments
        self.comment().subscribe(onNext: { [weak self] (comment: [Comment]) in
            print("Success")
            self?.realmData()
        }, onError: { (error: Error) in
            print("Error")
            self.realmData()
            
            self.refresh.endRefreshing()
        }, onCompleted: {
            print("Completed")
            
            self.refresh.endRefreshing()
        }).addDisposableTo(disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
