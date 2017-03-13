//
//  PostViewModel.swift
//  iOS-Base-Pattern
//
//  Created by Harditya on 3/10/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import ObjectMapper
import RealmSwift
import RxSwift

protocol PostViewModel {
}

extension PostViewModel {
    
    /// Get list of posts
    ///
    /// - Returns: return Posts The posts
    func post(provider: RxMoyaProvider<FakeJSONService>) -> Observable<[Post]> {
        let observable = Observable<[Post]>.create { (observer: AnyObserver<[Post]>) -> Disposable in
            provider.request(.allPosts).subscribe { event in
                switch event {
                case let .next(response):
                    do {
                        let responseString = try response.mapString()
                        let posts = Mapper<Post>().mapArray(JSONString: responseString)!
                        print("The Posts: \(posts.count)")
                        
                        let realm = try Realm()
                        try realm.write {
                            for post: Post in posts {
                                realm.add(post, update: true)
                            }
                        }
                        
                        observer.onNext(posts)
                        observer.onCompleted()
                    } catch (let error) {
                        print("[PostViewModel] ERROR: \(error)")
                        observer.onError(error)
                    }
                case let .error(error):
                    print("[PostViewModel] ERROR: \(error)")
                    observer.onError(error)
                default:
                    break
                }
            }
            
            return Disposables.create()
        }
        
        return observable
    }
    
}
