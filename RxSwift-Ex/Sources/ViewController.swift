//
//  ViewController.swift
//  RxSwift-Ex
//
//  Created by Harditya on 2/7/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class ViewController: UIViewController, CommentViewModel {
    
    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var theTextField: UITextField!

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let realm = try Realm()
            let comments = realm.objects(Comment.self)
            print("Comments: \(comments.count)")
            
            self.comment().subscribe(onNext: { [weak self] (comment: [Comment]) in
                print("On Next: \(comment)")
            }, onError: { (error: Error) in
                print("Error")
            }, onCompleted: { 
                print("Completed")
            }).addDisposableTo(disposeBag)
            
            let subscription = theTextField.rx.text.map { value in
                if value!.characters.count > 0 {
                    return "Value: \(value!)"
                } else {
                    return ""
                }
            }.bindTo(theLabel.rx.text)
            subscription.addDisposableTo(disposeBag)
        } catch (let error) {
            print("[ViewController] ERROR: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    @IBAction func button(_ sender: UIButton) {
        
    }

}

