//
//  PostTableViewController.swift
//  iOS-Base-Pattern
//
//  Created by Harditya on 3/10/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import UIKit
import Moya
import RealmSwift
import RxSwift
import RxCocoa

class PostTableViewController: UITableViewController, PostViewModel {

    let dataSource = PostTableViewDataSource()
    let disposeBag = DisposeBag()
    let provider = RxMoyaProvider<FakeJSONService>()
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init
    
    func initData() {
        // Posts
        self.post(provider: provider).subscribe(onNext: { [weak self](post: [Post]) in
            print("Success")
            self?.realmData()
        }, onError: { (error) in
            print("Error")
            self.realmData()
        }, onCompleted: { 
            print("Completed")
        }).addDisposableTo(disposeBag)
    }
    
    func initUI() {
        refresh.backgroundColor = UIColor.red
        refresh.tintColor = UIColor.white
        refresh.addTarget(self, action: #selector(TableViewController.reload), for: .valueChanged)
        self.refreshControl = refresh
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
    }
    
    // MARK: - Functions
    
    func realmData() {
        // Realm
        do {
            let realm = try Realm()
            self.dataSource.posts = realm.objects(Post.self).toArray()
            
            self.tableView.reloadData()
        } catch (let error) {
            print("[PostTableViewController] ERROR: \(error)")
        }
    }
    
    // MARK: - Refresh control
    
    func reload() {
        // Posts
        self.post(provider: provider).subscribe(onNext: { [weak self](post: [Post]) in
            print("Success")
            self?.realmData()
        }, onError: { (error) in
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
