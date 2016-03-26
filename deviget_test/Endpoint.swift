//
//  Endpoint.swift
//  deviget_test
//
//  Created by Fernando Rocha Silva on 3/26/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//  
//  Enum created to model API endpoints
//

import Foundation

let baseURL = "https://www.reddit.com/"

enum Endpoint {
    case TopPosts
    case TopPostsPagination(Int, String)
    
    func url() -> String {
        switch self {
        case .TopPosts:
            return baseURL.stringByAppendingString("r/all/top.json")
        case .TopPostsPagination(let pageCount, let lastPageId):
            return baseURL.stringByAppendingString("r/all/top.json?count=\(pageCount)&after=\(lastPageId)")
        }
    }
}