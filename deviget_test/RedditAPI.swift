//
//  RedditAPI.swift
//  deviget_test
//
//  Created by Fernando Rocha Silva on 3/23/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import Foundation

struct RedditAPI {
    private static let baseURLString = "https://www.reddit.com/r/all/top.json"
    
    private static func redditURL(parameters: [String:String]?) -> NSURL {
        let components = NSURLComponents(string: baseURLString)!
        
        var queryItems = [NSURLQueryItem]()
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.URL!
    }
    
    
}