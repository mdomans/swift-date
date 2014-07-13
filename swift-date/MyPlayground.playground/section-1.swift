// Playground - noun: a place where people can play

import UIKit
import Foundation

struct Date {
    var calendar:NSCalendar
    var timezone:NSTimeZone
    var dateComponents:NSDateComponents
    var _date:NSDate
    
    
    init(calendar:NSCalendar = NSCalendar.currentCalendar(), timezone:NSTimeZone = NSTimeZone(forSecondsFromGMT: 0), date:NSDate = NSDate()) {
        self.calendar = calendar
        self.timezone = timezone
        self.dateComponents = NSDateComponents()
        self._date = date
    }
    
    init(dateString: String) {
        self = Date.parse(dateString)
    }
    
    func description() -> NSString {
        return self._date.description
    }
    
    static func parse(dateString:String) -> Date {
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

@infix func < (left:Date, right:Date) -> Bool {
    return left._date.laterDate(right._date) != left._date
}

var d = Date()
var e = Date()
var f = e
var td = e - d
d == e
f == e
d < e
e < d
Date(dateString: "2012-04-07")

var x = d + td
x == e











