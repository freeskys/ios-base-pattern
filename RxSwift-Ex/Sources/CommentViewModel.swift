//
//  ViewViewModel.swift
//  RxSwift-Ex
//
//  Created by Harditya on 2/7/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import ObjectMapper
import RealmSwift
import RxSwift

protocol CommentViewModel {
}

extension CommentViewModel {
    
    /// Get list of comments
    ///
    /// - Returns: return Comments The comments
    func comment(provider: RxMoyaProvider<FakeJSONService>) -> Observable<[Comment]> {
        let observable = Observable<[Comment]>.create { (observer: AnyObserver<[Comment]>) -> Disposable in
            provider.request(.allComments).subscribe { event in
                switch event {
                case let .next(response):
                    do {
                        let responseString = try response.mapString()
                        let comments = Mapper<Comment>().mapArray(JSONString: responseString)!
                        print("The Comments: \(comments.count)")
                        
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
                case let .error(error):
                    print("[CommentViewModel] ERROR: \(error)")
                default:
                    break
                }
            }
            
            return Disposables.create()
        }
        
        return observable
    }
    
}
