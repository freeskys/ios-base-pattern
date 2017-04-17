//
//  BaseNetworking.swift
//  iOS-Base-Pattern
//
//  Created by Harditya on 4/17/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import Foundation
import UIKit

struct BaseNetworking {
    
    /// Run before calling networking process
    static func initNetworking() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
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
    
}
