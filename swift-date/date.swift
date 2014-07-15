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
    var date:NSDate
    
    
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
    var nanosecond:Int {
    get {
        return self.dateComponents.nanosecond
    }
    }
    
    init(
        calendar:NSCalendar = NSCalendar.currentCalendar(),
        timezone:NSTimeZone = NSTimeZone(forSecondsFromGMT: 0),
        date:NSDate = NSDate()
        ) {
        self.calendar = calendar
        self.timezone = timezone
        self.dateComponents = NSDateComponents()
        self.dateComponents.timeZone = self.timezone
        self.dateComponents.calendar = self.calendar
        self.date = date
    }
    init(day:Int, month:Int, year:Int, calendar:NSCalendar = NSCalendar.currentCalendar(),
        timezone:NSTimeZone = NSTimeZone(forSecondsFromGMT: 0)) {
            self.init()
            self.dateComponents.day=day
            self.dateComponents.month=month
            self.dateComponents.year=year
            self.date = self.calendar.dateFromComponents(self.dateComponents)
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
        return self.date.description
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
    init(components:NSDateComponents) {
        self.components = components
    }
    init(hours:Int=0, minutes:Int=0, seconds:Int=0, days:Int=0, months:Int=0, years:Int=0, nanoseconds:Int=0) {
        var comps:NSDateComponents = NSDateComponents()
        var m = (minutes + seconds / 60)
        var h = (hours +  m / 60)
        var d = (days + h / 24)
        comps.day = d 
        comps.month = months
        comps.year = years
        comps.hour = h % 24
        comps.minute = m % 60
        comps.second = seconds % 60
        comps.nanosecond = nanoseconds
        self.components = comps
    }

}

extension Int {
    var hours:TimeDelta {
    return TimeDelta(hours:self)
    }
    var minutes:TimeDelta {
    return TimeDelta(minutes:self)
    }
    var seconds:TimeDelta {
    return TimeDelta(seconds:self)
    }
    var years:TimeDelta {
    return TimeDelta(years:self)
    }
    var months:TimeDelta {
    return TimeDelta(years:self)
    }
    var days:TimeDelta {
    return TimeDelta(days:self)
    }
}

@infix func + (left:Date, right:TimeDelta) -> Date {
    var newDate = Date(calendar: left.calendar, timezone: left.timezone)
    var opts:NSCalendarOptions = .MatchStrictly
    newDate.date = left.calendar.dateByAddingComponents(right.components, toDate: left.date, options: opts)
    return newDate;
}

@infix func + (left:TimeDelta, right:TimeDelta) -> TimeDelta {
    return TimeDelta(
        hours: left.components.hour+right.components.hour,
        minutes: left.components.minute+right.components.minute,
        seconds: left.components.second+right.components.second,
        days: left.components.day+right.components.day,
        months: left.components.month+right.components.month,
        years: left.components.year+right.components.year,
        nanoseconds: left.components.nanosecond + right.components.nanosecond
    )
}

@infix func - (left:Date, right:TimeDelta) -> Date {
    var newDate = Date(calendar: left.calendar, timezone: left.timezone)
    var opts:NSCalendarOptions = .MatchStrictly
    let comps = NSDateComponents()
    comps.year = -1 * right.components.year
    comps.month = -1 * right.components.month
    comps.day = -1 * right.components.day
    comps.hour = -1 * right.components.hour
    comps.minute = -1 * right.components.minute
    comps.second = -1 * right.components.second
    comps.nanosecond = -1 * right.components.nanosecond
    newDate.date = left.calendar.dateByAddingComponents(comps, toDate: left.date, options: opts)
    return newDate;
}

@infix func - (left:Date, right:Date) -> TimeDelta {
    assert(left.calendar==right.calendar, "dates have to be from the same calendar")
    let calendar:NSCalendar = left.calendar
    let calendarUnits:NSCalendarUnit = .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond | .CalendarUnitNanosecond | .CalendarUnitWeekday | .CalendarUnitYear
    let options:NSCalendarOptions = .WrapComponents
    let comps:NSDateComponents = calendar.components(calendarUnits, fromDate: right.date, toDate: left.date, options: options)
    return TimeDelta(components: comps)
}

@infix func == (left:Date, right:Date) -> Bool {
    return left.date.isEqualToDate(right.date)
}

@infix func == (left:TimeDelta, right:TimeDelta) -> Bool {
    return left.components.year == right.components.year &&
        left.components.month == right.components.month &&
        left.components.day == right.components.day &&
        left.components.hour == right.components.hour &&
        left.components.minute == right.components.minute &&
        left.components.second == right.components.second &&
        left.components.nanosecond == right.components.nanosecond
}

@infix func ~= (left:Date, right:NSDate) -> Bool {
    return left.date.isEqualToDate(right)
}

@infix func ~= (left:NSDate, right:Date) -> Bool {
    return left.isEqualToDate(right.date)
}

@infix func < (left:Date, right:Date) -> Bool {
    return left.date.laterDate(right.date) != left.date
}



