//
//  TableViewController.swift
//  RxSwift-Ex
//
//  Created by Harditya on 2/9/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import UIKit
import Moya
import RealmSwift
import RxSwift
import RxCocoa

class TableViewController: UITableViewController, CommentViewModel {

    let dataSource = CommentTableViewDataSource()
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
        // Comments
        self.comment(provider: provider).subscribe(onNext: { [weak self] (comment: [Comment]) in
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
            self.dataSource.comments = realm.objects(Comment.self).toArray()
            
            self.tableView.reloadData()
        } catch (let error) {
            print("[TableViewController] ERROR: \(error)")
        }
    }
    
    // MARK: - Refresh control

    func reload() {
        // Comments
        self.comment(provider: provider).subscribe(onNext: { [weak self] (comment: [Comment]) in
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
