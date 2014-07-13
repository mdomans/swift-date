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

    func testCreation() {
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
    
    func dateFromComponents(day:Int, month:Int, year:Int, hour:Int, minute:Int, second:Int) -> NSDate {
        var cal = NSCalendar.currentCalendar()
        cal.timeZone = NSTimeZone.localTimeZone()
        var comps = NSDateComponents()
        comps.day = day
        comps.year = year
        comps.second = second
        comps.hour = hour
        comps.minute = minute
        comps.month = month
        return cal.dateFromComponents(comps)
    }
    
    func testSubtraction() {
        var d = Date()
        var e = Date()
        var td = d - e
        XCTAssertNotNil(td.components, "subtraction doesn't work")
    }
    
    func testCompares() {
        // This is an example of a functional test case.
        
        var d = Date()
        var e = Date()
        var f = e
        var td = d - e
        XCTAssertFalse(d == e, "")
        XCTAssertTrue(f == e, "")
        XCTAssertTrue(d < e, "")
        XCTAssertFalse(e < d, "")
    }
    
    func testAddition() {
        var then = Date()
        var later = Date()
        var copyOfThen = then
        var timedelta = later - then
        XCTAssertTrue((copyOfThen + timedelta) == later, "timedeltas doesn't work")
        
    }

    func testParse() {
        
        var date = Date(dateString: "2014-03-10 12:00:00 PST")
        XCTAssertTrue(date ~= self.dateFromComponents(10, month: 3, year: 2014, hour: 20, minute: 00, second: 00), "")
        XCTAssertFalse(date ~= self.dateFromComponents(10, month: 3, year: 2014, hour: 19, minute: 00, second: 00), "")
        XCTAssertFalse(date ~= self.dateFromComponents(10, month: 3, year: 2014, hour: 21, minute: 00, second: 00), "")
        XCTAssertTrue(date.timezone == NSTimeZone.localTimeZone(), "")

    }
    
    func testComponents() {
        var now = Date()
        XCTAssertNotNil(now.day, "")
        XCTAssertNotNil(now.month, "")
        XCTAssertNotNil(now.year, "")
        XCTAssertNotNil(now.hour, "")
        XCTAssertNotNil(now.second, "")
    }
    
    func testAlmostEqual() {
        var aNSDateInstance = NSDate()
        var aDateInstance = Date(date:aNSDateInstance)
        XCTAssertTrue(aDateInstance ~= aNSDateInstance , "Date should be almost equal to NSDate")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
