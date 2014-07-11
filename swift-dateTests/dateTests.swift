//
//  dateTests.swift
//  swift-date
//
//  Created by mdomans on 11/07/14.
//  Copyright (c) 2014 mdomans. All rights reserved.
//

import UIKit
import XCTest

class dateTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        
        var d = Date()
        var e = Date()
        var f = e
        var td = d - e
        XCTAssertFalse(d == e, "test")
        XCTAssertTrue(f == e, "test2")
        XCTAssertTrue(d < e, "")
        XCTAssertFalse(e < d, "")
        Date(dateString: "2012-04-07")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
