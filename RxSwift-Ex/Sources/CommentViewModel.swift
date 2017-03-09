//
//  ViewViewModel.swift
//  RxSwift-Ex
//
//  Created by Harditya on 2/7/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RealmSwift
import RxSwift

protocol CommentViewModel {
}

extension CommentViewModel {
    
    /// Get list of comments
    ///
    /// - Returns: return Comments The comments
    func comment() -> Observable<[Comment]> {
        let observable = Observable<[Comment]>.create { (observer: AnyObserver<[Comment]>) -> Disposable in
            let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
            Alamofire.request(url).responseString { (response: DataResponse<String>) in
                if let value = response.result.value {
                    let comments = Mapper<Comment>().mapArray(JSONString: value)!
                    print("The Comments: \(comments.count)")
                    
                    do {
                        let realm = try Realm()
                        try realm.write {
                            for comment: Comment in comments {
                                realm.add(comment, update: true)
                            }
                        }
                        
                        observer.onNext(comments)
                        observer.onCompleted()
                    } catch (let error) {
                        print("[CommentViewModel] ERROR: \(error)")
                    }
                } else if let error = response.result.error {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
        
        return observable
    }
    
}
