//
//  date.swift
//  swift-date
//
//  Created by mdomans on 11/07/14.
//  Copyright (c) 2014 mdomans. All rights reserved.
//

import Foundation

struct Date {
    var calendar:NSCalendar
    var timezone:NSTimeZone
    var dateComponents:NSDateComponents
    var _date:NSDate
    
    
    var day:Int {
    get {
        return self.dateComponents.day
    }
    }
    var month:Int {
    get {
        return self.dateComponents.month
    }
    }
    var year:Int {
    get {
        return self.dateComponents.year
    }
    }
    var hour:Int {
    get {
        return self.dateComponents.hour
    }
    }
    var second:Int {
    get {
        return self.dateComponents.second
    }
    }
    
    init(calendar:NSCalendar = NSCalendar.currentCalendar(), timezone:NSTimeZone = NSTimeZone(forSecondsFromGMT: 0), date:NSDate = NSDate()) {
        self.calendar = calendar
        self.timezone = timezone
        self.dateComponents = NSDateComponents()
        self._date = date
    }
    ///Creates a Date from given string, always remember that this method returns
    /// objects in NSTimeZone.localTimeZone()
    ///
    ///@param dateString:String
    /// String to parse
    ///
    ///@return
    /// Date
    init(dateString: String) {
        self = Date.parse(dateString)
        self.timezone = NSTimeZone.localTimeZone()
    }
    
    func description() -> NSString {
        return self._date.description
    }
    
    static func parse(dateString:String) -> Date {
        var error: NSError?
        let types:NSTextCheckingTypes = NSTextCheckingType.Date.toRaw()
        let detector = NSDataDetector.dataDetectorWithTypes(types, error: &error)
        let matches = detector.matchesInString(dateString, options: nil, range: NSRange(location: 0, length: countElements(dateString)))
        if let firstMatch: NSTextCheckingResult = matches[0] as? NSTextCheckingResult {
            if (firstMatch.resultType.toRaw() == NSTextCheckingType.Date.toRaw()) {
                return Date(date:firstMatch.date)
            }
        }
        return Date()
    }
}

struct TimeDelta {
    let components:NSDateComponents

}

@infix func + (left:Date, right:TimeDelta) -> Date {
    var newDate = Date(calendar: left.calendar, timezone: left.timezone)
    var opts:NSCalendarOptions = .MatchStrictly
    newDate._date = left.calendar.dateByAddingComponents(right.components, toDate: left._date, options: opts)
    return newDate;
}

@infix func - (left:Date, right:TimeDelta) -> Date {
    var newDate = Date(calendar: left.calendar, timezone: left.timezone)
    var opts:NSCalendarOptions = .MatchStrictly
    newDate._date = left.calendar.dateByAddingComponents(right.components, toDate: left._date, options: opts)
    return newDate;
}

@infix func - (left:Date, right:Date) -> TimeDelta {
    assert(left.calendar==right.calendar, "dates have to be from the same calendar")
    let calendar:NSCalendar = left.calendar
    let calendarUnits:NSCalendarUnit = .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond | .CalendarUnitNanosecond | .CalendarUnitWeekday | .CalendarUnitYear
    let options:NSCalendarOptions = .WrapComponents
    let comps:NSDateComponents = calendar.components(calendarUnits, fromDate: right._date, toDate: left._date, options: options)
    return TimeDelta(components: comps)
}

@infix func == (left:Date, right:Date) -> Bool {
    return left._date.isEqualToDate(right._date)
}

@infix func ~= (left:Date, right:NSDate) -> Bool {
    return left._date.isEqualToDate(right)
}

@infix func ~= (left:NSDate, right:Date) -> Bool {
    return left.isEqualToDate(right._date)
}

@infix func < (left:Date, right:Date) -> Bool {
    return left._date.laterDate(right._date) != left._date
}



