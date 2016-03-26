//
//  deviget_testTests.swift
//  deviget_testTests
//
//  Created by Fernando Rocha Silva on 3/22/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import XCTest
@testable import deviget_test

class deviget_endpointTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEndpointCreation() {
        // This is an example of a functional test case.
        
        XCTAssertTrue(Endpoint.TopPosts.url() == "https://www.reddit.com/r/all/top.json")
        XCTAssertTrue(Endpoint.TopPostsPagination(2, "PageId").url() == "https://www.reddit.com/r/all/top.json?count=2&after=PageId")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
