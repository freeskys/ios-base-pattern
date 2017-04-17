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

class PostTableViewController: BaseTableViewController, PostViewModel {

    let posts = Variable<[Post]>([])
    
    let dataSource = PostTableViewDataSource()
    let disposeBag = DisposeBag()
    let provider = RxMoyaProvider<FakeJSONService>()
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init
    
    override func initData() {
        super.initData()
        
        // Load realm
        self.realmData()
        
        // Load backend
        self.backendData()
    }
    
    override func initUI() {
        super.initUI()
        
        refresh.backgroundColor = UIColor.red
        refresh.tintColor = UIColor.white
        refresh.addTarget(self, action: #selector(TableViewController.reload), for: .valueChanged)
        self.refreshControl = refresh
        
        tableView.dataSource = nil
        posts.asObservable().bind(to: tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
    }
    
    // MARK: - Functions
    
    func backendData() {
        // Show network indicator
        BaseNetworking.initNetworking()
        
        // Posts
        self.post(provider: provider).subscribe(onNext: { [weak self](post: [Post]) in
            print("Success")
            
            BaseNetworking.onSuccess()
        }, onError: { (error) in
            print("Error")
            
            BaseNetworking.onError()
            self.refresh.endRefreshing()
        }, onCompleted: {
            print("Completed")
            
            // Load realm
            self.realmData()
            BaseNetworking.onCompleted()
            self.refresh.endRefreshing()
        }).addDisposableTo(disposeBag)
    }
    
    func realmData() {
        // Realm
        do {
            let realm = try Realm()
            self.posts.value = realm.objects(Post.self).toArray()
        } catch (let error) {
            print("[PostTableViewController] ERROR: \(error)")
        }
    }
    
    // MARK: - Refresh control
    
    override func reload() {
        // Load backend
        self.backendData()
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
