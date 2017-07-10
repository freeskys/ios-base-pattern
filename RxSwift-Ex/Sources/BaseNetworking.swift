//
//  BaseNetworking.swift
//  iOS-Base-Pattern
//
//  Created by Harditya on 4/17/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift

struct BaseNetworking {
    
    // MARK: - Init
    
    /// Run before calling networking process
    static func initNetworking() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // MARK: - Callbacks
    
    /// Called when networking process success
    static func onSuccess() {
        
    }
    
    /// Called when networking process error
    static func onError() {
        
    }
    
    /// Called after networking process completed
    static func onCompleted() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - Functions
    
    /// Do a networking process
    ///
    /// - Parameters:
    ///   - success: success If internet is reachable
    ///   - failure: failure If internet is not reachable
    static func process(success: () -> Void,
                        failure: () -> Void) {
        guard let reachability = Reachability() else {
            return
        }
        
        if reachability.isReachable {
            success()
        } else {
            failure()
        }
    }
    
}
