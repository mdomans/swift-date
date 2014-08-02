//
//  dateTests.swift
//  swift-date
//
//  Created by mdomans on 11/07/14.
//  Copyright (c) 2014 mdomans. All rights reserved.
//

import UIKit
import XCTest
import swiftDate

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
        var twentieth_of_may2014 = Date(day: 20, month: 5, year: 2014)
        XCTAssertTrue(twentieth_of_may2014.day==20, "")
        XCTAssertTrue(twentieth_of_may2014.month==5, "")
        XCTAssertTrue(twentieth_of_may2014.year==2014, "")

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
    
    func testDateStrings () {
        XCTAssertTrue(Date(dateString: "2014-10-14")==Date(day: 14, month: 10, year: 2014), "")
        XCTAssertTrue(Date(dateString: "14 October 2014")==Date(day: 14, month: 10, year: 2014), "")
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
    
    func testSyntaxSugar() {
        var timedelta = 5.days + 2.days + 3.hours + 32.seconds
        XCTAssertTrue(120.seconds==2.minutes, "")
        XCTAssertTrue(120.minutes==2.hours, "")
        XCTAssertTrue(48.hours==2.days, "")
        XCTAssertFalse(365.days==1.years, "")
    }
    
    func testSugarCreation() {
        Date(day: 12, month: 2, year: 2014) - 2.years == Date(day: 12, month: 2, year: 2012)
        
        XCTAssertTrue(Date(day: 10, month: 2, year: 2014)+2.days==Date(day: 12, month: 2, year: 2014), "")
        XCTAssertTrue(Date(day: 12, month: 2, year: 2014)-2.years==Date(day: 12, month: 2, year: 2012), "")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
